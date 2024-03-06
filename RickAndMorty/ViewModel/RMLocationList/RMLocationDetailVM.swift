//
//  RMLocationDetailVM.swift
//  RickAndMorty
//
//  Created by Arda Büyükhatipoğlu on 6.03.2024.
//

import Foundation

protocol RMLocationDetailVMDelegate: AnyObject {
        func didFetchLocationDetails()
}

final class RMLocationDetailVM {
    
    private let endpointURL: URL?
    private var dataTuple: (location: RMLocation, characters: [RMCharacter])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchLocationDetails()
        }
    }
    
    enum SectionType {
        case information(viewModels: [RMEpisodeInfoCollectionCellVM])
        case characters(viewModels: [RMCharacterCollectionViewCellVM])
    }
    
    weak var delegate: RMLocationDetailVMDelegate?
    
    private(set) var cellViewModels: [SectionType] = []
    
    private(set) var locationTitle: String?
    
    init(url: URL?) {
        endpointURL = url
        fetchEpisodeData()
    }
    
    //MARK: * Public
    
    //MARK: - Private
    
    private func createCellViewModels() {
        guard let dataTuple = dataTuple else { return }
        
        let location = dataTuple.location
        let characters = dataTuple.characters
        cellViewModels = [
            .information(viewModels: [
                .init(title: "Location Name", value: location.name),
                .init(title: "Type", value: location.type),
                .init(title: "Dimension", value:  location.dimension),
                .init(title: "Created", value:  location.created.formatDateFromISOToString() ?? "N/A"),
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
        
        RMService.shared.execute(request, expecting: RMLocation.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.locationTitle = model.name
                self?.fetchLocationCharacters(location: model)
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
    
    
    private func fetchLocationCharacters(location: RMLocation) {
        let characUrls: [URL] = location.residents.compactMap({
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
            self.dataTuple = (location, characters)
        }
    }
    
    
    func getCharacterAtIndex(_ index: Int) -> RMCharacter? {
        guard let dataTuple = dataTuple else {
            return nil
        }
        return dataTuple.characters[index]
    }
    
}
