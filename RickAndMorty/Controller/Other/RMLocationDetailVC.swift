//
//  RMLocationDetailVC.swift
//  RickAndMorty
//
//  Created by Arda Büyükhatipoğlu on 6.03.2024.
//

import UIKit

class RMLocationDetailVC: UIViewController {

    private let viewModel: RMLocationDetailVM
    private let locationView = RMLocationDetailView()
    
    init(url: URL?) {
        self.viewModel = RMLocationDetailVM(url: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        viewModel.delegate = self
        locationView.delegate = self
        viewModel.fetchEpisodeData()
    }
    
    
    private func configureVC() {
        view.addSubview(locationView)
        view.backgroundColor = .systemBackground
        locationView.pinToEdgesWithSafeAreaLayoutGuide(of: view)
        title = "Location"
    }

}


extension RMLocationDetailVC: RMLocationDetailVMDelegate, RMLocationDetailViewDelegate {
    
    func didFetchLocationDetails() {
        locationView.configure(with: viewModel)
    }
    
    
    func rmLocationDetailView(_ detailView: RMLocationDetailView, didSelect character: RMCharacter) {
        let characterDetailVM = RMCharacterDetailVM(character: character)
        let vc = RMCharacterDetailVC(with: characterDetailVM)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
