//
//  RMEpisodeDetailVC.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 16.02.2024.
//

import UIKit

class RMEpisodeDetailVC: UIViewController {

    private let viewModel: RMEpisodeDetailVM
    private let episodeView = RMEpisodeDetailView()
    
    init(url: URL?) {
        self.viewModel = RMEpisodeDetailVM(url: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        viewModel.delegate = self
        episodeView.delegate = self
        viewModel.fetchEpisodeData()
    }
    
    
    private func configureVC() {
        view.addSubview(episodeView)
        view.backgroundColor = .systemBackground
        episodeView.pinToEdgesWithSafeAreaLayoutGuide(of: view)
        title = "Episode"
    }
    
    
}

extension RMEpisodeDetailVC: RMEpisodeDetailVMDelegate, RMEpisodeDetailViewDelegate {
    
    func didFetchEpisodeDetails() {
        episodeView.configure(with: viewModel)
    }
    
    
    func rmEpisodeDetailView(_ detailView: RMEpisodeDetailView, didSelect character: RMCharacter) {
        let characterDetailVM = RMCharacterDetailVM(character: character)
        let vc = RMCharacterDetailVC(with: characterDetailVM)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
