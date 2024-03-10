//
//  RMSearchVC.swift
//  RickAndMorty
//
//  Created by Arda Büyükhatipoğlu on 25.02.2024.
//

import UIKit

//Dynamic search option view
//Render results
//Render no results zero state
//Searching / API Call

//Configuration for Search View Controller
struct SearchCategory {
    enum `Type`{
        case character // name | status | gender
        case episode // name
        case location // name | type
        
        var title: String {
            switch self {
            case .character:
                return "Search Character"
            case .episode:
                return "Search Episode"
            case .location:
                return "Search Location"
            }
        }
    }
    
    let type: Type
}


class RMSearchVC: UIViewController {

    private let searchCategory: SearchCategory
    private let searchView: RMSearchView
    
    init(searchCategory: SearchCategory) {
        self.searchCategory = searchCategory
        self.searchView = RMSearchView(frame: .zero, viewModel: RMSearchViewVM(config: searchCategory))
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = searchCategory.type.title
        
        view.addSubview(searchView)
        searchView.pinToEdgesWithSafeAreaLayoutGuide(of: view)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .done, target: self, action: #selector(searchButtonTapped))
    }
    
    
    @objc private func searchButtonTapped(){
        //viewModel.executeSearch
    }
}
