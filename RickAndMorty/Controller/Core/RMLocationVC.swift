//
//  RMLocationVC.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 30.01.2024.
//

import UIKit

class RMLocationVC: UIViewController {

    private let locationListView = RMLocationListView()
    private let viewModel = RMLocationListVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSearchButton()
        
        view.addSubview(locationListView)
        locationListView.pinToEdgesWithSafeAreaLayoutGuide(of: view)
    }
    
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
    }
    
    
    @objc private func searchTapped() {
        let searchVC = RMSearchVC(searchCategory: .init(type: .location))
        navigationController?.pushViewController(searchVC, animated: true)
    }

}
