//
//  RMEpisodeVC.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 30.01.2024.
//

import UIKit

class RMEpisodeVC: UIViewController {

    private let episodeListview = RickAndMorty.RMEpisodeListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureEpisodeListVC()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureEpisodeListVC() {
        view.addSubview(episodeListview)
        episodeListview.delegate = self
        episodeListview.pinToEdgesWithSafeAreaLayoutGuide(of: view)
    }
    
    //Delegate function here RMEpisodeListViewDelegate
    
    func RMCharacterListView(_ rmCharacterListView: RMCharacterListView, didSelectCharacter character: RMCharacter) {
        let detailViewModel = RMCharacterDetailVM(character: character)
        let characterDetailVC = RMCharacterDetailVC(with: detailViewModel)
        characterDetailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(characterDetailVC, animated: true)
    }
}

extension RMEpisodeVC: RMEpisodeListViewDelegate {
    func RMEpisodeListView(_ rmEpisodeListView: RMEpisodeListView, didSelectEpisode episode: RMEpisode) {
        let episodeDetailVC = RMEpisodeDetailVC(url: URL(string: episode.url))
        episodeDetailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(episodeDetailVC, animated: true)

    }
    
    
}
