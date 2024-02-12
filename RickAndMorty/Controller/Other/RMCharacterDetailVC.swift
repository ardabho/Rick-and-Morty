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


extension RMCharacterDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 8
        case 2:
            return 20
        default:
            return 1
            
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        switch viewModel.sections[indexPath.section] {
        case .photo:
            cell.backgroundColor = .cyan
        case .information:
            cell.backgroundColor = .systemGreen
        case .episodes:
            cell.backgroundColor = .brown
        }
        
        return cell
    }
    
    
}
