//
//  RMEpisodeListView.swift
//  RickAndMorty
//
//  Created by Arda Büyükhatipoğlu on 25.02.2024.
//

import UIKit

protocol RMEpisodeListViewDelegate: AnyObject {
    func RMEpisodeListView(_ rmEpisodeListView: RMEpisodeListView, didSelectEpisode episode: RMEpisode)
}

///View that handles showing list of episodes, loader, etc.
class RMEpisodeListView: UIView {
    

    private let viewModel = RMEpisodeListViewVM()
    private let loadingSpinner = RMLoadingSpinnerView()
    private var collectionView: UICollectionView!
    
    weak var delegate: RMEpisodeListViewDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureLoadingSpinner()
        configureCollectionView()
        getEpisodeData()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        viewModel.delegate = self
    }
    
    
    private func configureLoadingSpinner() {
        addSubview(loadingSpinner)
        loadingSpinner.pinToEdges(of: self)
    }
    
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createSingleColumnFlowLayout(in: self))
        collectionView.register(RMEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: RMEpisodeCollectionViewCell.identifier)
        collectionView.register(RMFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier)
        
        addSubview(self.collectionView)
        
        collectionView.isHidden = true
        collectionView.alpha = 0
    
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource   = viewModel
        collectionView.delegate     = viewModel
        
        self.collectionView.pinToEdges(of: self)
    }
    
    
    private func getEpisodeData() {
        loadingSpinner.startLoadingAnimation()
        viewModel.fetchEpisodes()
    }
}


extension RMEpisodeListView: RMEpisodeListViewVMDelegate {
    func didLoadInitialEpisodes() {
        collectionView.reloadData()
        collectionView.isHidden = false
        loadingSpinner.stopLoadingAnimation()
        UIView.animate(withDuration: 0.5) {
            self.collectionView.alpha = 1
        }

    }
    
    func didSelectEpisode(_ episode: RMEpisode) {
        self.delegate?.RMEpisodeListView(self, didSelectEpisode: episode)
    }
    
    
    func didLoadAdditionalEpisodes(with newIndexpaths: [IndexPath]) {
        DispatchQueue.main.async {
            self.collectionView.performBatchUpdates {
                self.collectionView.insertItems(at: newIndexpaths)
            }
        }
    }
}
