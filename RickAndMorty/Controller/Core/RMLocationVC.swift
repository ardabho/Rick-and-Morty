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
        view.backgroundColor = .systemBackground
        addSearchButton()
        configureLocationListView()
        configureViewModel()
    }
    
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
    }
    
    
    private func configureLocationListView() {
        view.addSubview(locationListView)
        locationListView.delegate = self
        locationListView.pinToEdgesWithSafeAreaLayoutGuide(of: view)
    }
    
    
    private func configureViewModel() {
        viewModel.delegate = self
        viewModel.fetchLocations()
    }
    
    
    @objc private func searchTapped() {
        let searchVC = RMSearchVC(searchCategory: .init(type: .location))
        navigationController?.pushViewController(searchVC, animated: true)
    }

}


extension RMLocationVC: RMLocationListVMDelegate {
    
    func didFinishFetchingInitialLocations() {
        locationListView.configure(with: viewModel)
    }
}


extension RMLocationVC: RMLocationListViewDelegate {
    func rmLocationListView(_ view: RMLocationListView, didSelect location: RMLocation) {
        let vc = RMLocationDetailVC(url: URL(string: location.url))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
