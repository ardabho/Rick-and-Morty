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
        addSearchButton()
    }
    
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    
    private func configureEpisodeListVC() {
        view.addSubview(episodeListview)
        episodeListview.delegate = self
        episodeListview.pinToEdgesWithSafeAreaLayoutGuide(of: view)
    }
    
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
    }
    
    
    @objc private func searchTapped() {
        let searchVC = RMSearchVC(searchCategory: .init(type: .episode))
        navigationController?.pushViewController(searchVC, animated: true)
    }
}

extension RMEpisodeVC: RMEpisodeListViewDelegate {
    func RMEpisodeListView(_ rmEpisodeListView: RMEpisodeListView, didSelectEpisode episode: RMEpisode) {
        let episodeDetailVC = RMEpisodeDetailVC(url: URL(string: episode.url))
        episodeDetailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(episodeDetailVC, animated: true)

    }
}
