//
//  RMEpisodeDetailVM.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 17.02.2024.
//

import Foundation

protocol RMEpisodeDetailVMDelegate: AnyObject {
        func didFetchEpisodeDetails()
}

final class RMEpisodeDetailVM {
    
    private let endpointURL: URL?
    private var dataTuple: (episode: RMEpisode, characters: [RMCharacter])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchEpisodeDetails()
        }
    }
    
    enum SectionType {
        case information(viewModels: [RMEpisodeInfoCollectionCellVM])
        case characters(viewModels: [RMCharacterCollectionViewCellVM])
    }
    
    weak var delegate: RMEpisodeDetailVMDelegate?
    
    private(set) var cellViewModels: [SectionType] = []
    
    private(set) var episodeTitle: String?
    
    init(url: URL?) {
        endpointURL = url
        fetchEpisodeData()
    }
    
    //MARK: * Public
    
    //MARK: - Private
    
    private func createCellViewModels() {
        guard let dataTuple = dataTuple else { return }
        
        let episode = dataTuple.episode
        let characters = dataTuple.characters
        cellViewModels = [
            .information(viewModels: [
                .init(title: "Episode Name", value: episode.name),
                .init(title: "Air Date", value: episode.airDate),
                .init(title: "Episode", value: episode.episode),
                .init(title: "Created", value: episode.created.formatDateFromISOToString() ?? "N/A"),
            ]),
            .characters(viewModels: characters.compactMap({ character in
                return RMCharacterCollectionViewCellVM(
                    characterName: character.name,
                    characterStatus: character.status,
                    imageURL: URL(string: character.image)
                )
            }))
        ]
    }
    
    
    func fetchEpisodeData() {
        guard let url = endpointURL, let request = RMRequest(url: url) else {
            return
        }
        
        RMService.shared.execute(request, expecting: RMEpisode.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.episodeTitle = model.name
                self?.fetchEpisodeCharacters(episode: model)
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
    
    
    private func fetchEpisodeCharacters(episode: RMEpisode) {
        let characUrls: [URL] = episode.characters.compactMap({
            return URL(string: $0)
        })
        
        let requests: [RMRequest] = characUrls.compactMap({
            return RMRequest(url: $0)
        })
        
        let group = DispatchGroup()
        var characters: [RMCharacter] = []
        
        for request in requests {
            group.enter()
            RMService.shared.execute(request, expecting: RMCharacter.self) { result in
                defer {
                    group.leave()
                }
                switch result {
                case .success(let model):
                    characters.append(model)
                case .failure:
                    break
                }
            }
        }
        
        group.notify(queue: .main) {
            self.dataTuple = (episode, characters)
        }
    }
    
    
    func getCharacterAtIndex(_ index: Int) -> RMCharacter? {
        guard let dataTuple = dataTuple else {
            return nil
        }
        return dataTuple.characters[index]
    }
    
}
