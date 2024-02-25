//
//  RMEpisodeListViewVM.swift
//  RickAndMorty
//
//  Created by Arda Büyükhatipoğlu on 25.02.2024.
//

import UIKit

protocol RMEpisodeListViewVMDelegate: AnyObject {
    func didLoadInitialEpisodes()
    func didSelectEpisode(_ episode: RMEpisode)
    func didLoadAdditionalEpisodes(with newIndexpaths: [IndexPath])
}


final class RMEpisodeListViewVM: NSObject {
    
    weak var delegate: RMEpisodeListViewVMDelegate?
    
    private var episodes: [RMEpisode] = [] {
        didSet {
            for episode in episodes {
                let viewModel = RMEpisodeListCollectionViewCellVM(name: episode.name, episode: episode.episode, airDate: episode.airDate)
                
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    private var cellViewModels: [RMEpisodeListCollectionViewCellVM] = [] //Array of View Models to populate collection view
    private var apiInfo: RMInfo? = nil
    private var isLoadingMoreEpisodes = false

    
    func fetchEpisodes() {
        RMService.shared.execute(.listEpisodesRequests, expecting: RMEpisodesResponse.self) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let episodesResponse):
                self.episodes = episodesResponse.results
                self.apiInfo    = episodesResponse.info
                DispatchQueue.main.async {
                    self.delegate?.didLoadInitialEpisodes()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func fetchAdditionalEpisodes(from url: URL) {
        isLoadingMoreEpisodes = true
        guard let request = RMRequest(url: url) else {
            isLoadingMoreEpisodes = false
            print("Failed to create request")
            return
        }
        
        RMService.shared.execute(request, expecting: RMEpisodesResponse.self) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let responseModel):
                
                self.apiInfo = responseModel.info
                
                let originalCount = self.episodes.count
                let newCount = responseModel.results.count
                let totalCount = originalCount + newCount
                let startingIndex = totalCount - newCount
                let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex + newCount)).compactMap({return IndexPath(row: $0, section: 0)})
                
                self.episodes.append(contentsOf: responseModel.results)

                self.delegate?.didLoadAdditionalEpisodes(with: indexPathsToAdd)
                self.isLoadingMoreEpisodes = false
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
    
    var shouldShowLoadingIndicator: Bool {
        return apiInfo?.next != nil
    }
}

// MARK: - Collection View

extension RMEpisodeListViewVM: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMEpisodeCollectionViewCell.identifier, for: indexPath) as? RMEpisodeCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureList(with: cellViewModels[indexPath.row])
        return cell
    }
    
    
    //Footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter else {
            return UICollectionReusableView()
        }
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier, for: indexPath) as! RMFooterLoadingCollectionReusableView
        
        shouldShowLoadingIndicator ? cell.startLoadingAnimation() : cell.stopLoadingAnimation()
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadingIndicator else {
            return .zero
        }
        
        return CGSize(width: collectionView.bounds.width, height: 65)
    }
    
    
    //Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectEpisode(episodes[indexPath.row])
    }
}

// MARK: - Scrollview

extension RMEpisodeListViewVM: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadingIndicator, !isLoadingMoreEpisodes, !cellViewModels.isEmpty,
              let nextUrlString = apiInfo?.next,
                let url = URL(string: nextUrlString) else {
            return
        }
        let offsetY = scrollView.contentOffset.y
        let totalContentHeight = scrollView.contentSize.height
        let scrollviewFrameHeight = scrollView.frame.height
        
        if (offsetY >= totalContentHeight - scrollviewFrameHeight - 85) {
            fetchAdditionalEpisodes(from: url)
        }
    }
}
