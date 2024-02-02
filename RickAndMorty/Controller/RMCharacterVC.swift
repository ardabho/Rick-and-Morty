//
//  RMCharacterVC.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 30.01.2024.
//

import UIKit

class RMCharacterVC: UIViewController {

    private let characterListView = CharacterListView()
    
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
        characterListView.pinToEdgesWithSafeAreaLayoutGuide(of: view)
    }
    
}
