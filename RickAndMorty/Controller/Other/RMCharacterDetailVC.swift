//
//  RMCharacterDetailVC.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 5.02.2024.
//

import UIKit

class RMCharacterDetailVC: UIViewController {
    
    private let viewModel: RMCharacterDetailVM
    private let detailView: RMCharacterDetailView
    
    // MARK: init
    
    init(with viewModel: RMCharacterDetailVM) {
        self.viewModel = viewModel
        self.detailView = RMCharacterDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureDetailView()
        
    }
    

    private func configureVC() {
        view.backgroundColor = .systemBackground
        title = viewModel.nameText
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
    }
    
    
    private func configureDetailView() {
        view.addSubview(detailView)
        detailView.pinToEdgesWithSafeAreaLayoutGuide(of: self.view)
        detailView.collectionView?.dataSource = self
        detailView.collectionView?.delegate = self
    }
    
    
    @objc
    private func didTapShare() {
        //share character info
    }
    
}


// MARK: Collection view methods

extension RMCharacterDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        
        switch sectionType {
        case .photo:
            return 1
        case .information(let viewModels):
            return viewModels.count
        case .episodes(viewModels: let viewModels):
            return viewModels.count
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch viewModel.sections[indexPath.section] {
        case .photo(let viewModel):
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterPhotoCollectionViewCell.identifier, for: indexPath) as? RMCharacterPhotoCollectionViewCell {
                cell.configure(with: viewModel)
                return cell
            }
        case .information(let viewModels):
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RmCharacterDetailInfoViewCell.identifier, for: indexPath) as? RmCharacterDetailInfoViewCell {
                cell.configure(with: viewModels[indexPath.row])
                return cell
            }
        case .episodes(let viewModels):
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMEpisodeCollectionViewCell.identifier, for: indexPath) as? RMEpisodeCollectionViewCell {
                cell.backgroundColor = .blue
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
    
}
