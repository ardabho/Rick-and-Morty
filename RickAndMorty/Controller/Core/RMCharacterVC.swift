//
//  RMCharacterVC.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 30.01.2024.
//

import UIKit

class RMCharacterVC: UIViewController, RMCharacterListViewDelegate {
    
    private let characterListView = RickAndMorty.RMCharacterListView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCharacterListVC()
    }
    
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    
    private func configureCharacterListVC() {
        view.addSubview(characterListView)
        characterListView.delegate = self
        characterListView.pinToEdgesWithSafeAreaLayoutGuide(of: view)
    }
    
    
    func RMCharacterListView(_ rmCharacterListView: RMCharacterListView, didSelectCharacter character: RMCharacter) {
        let detailViewModel = RMCharacterDetailVM(character: character)
        let characterDetailVC = RMCharacterDetailVC(with: detailViewModel)
        characterDetailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(characterDetailVC, animated: true)
    }
    
}
