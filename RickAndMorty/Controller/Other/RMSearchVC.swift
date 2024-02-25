//
//  RMSearchVC.swift
//  RickAndMorty
//
//  Created by Arda Büyükhatipoğlu on 25.02.2024.
//

import UIKit


struct SearchCategory {
    enum `Type`{
        case character
        case episode
        case location
    }
    
    let type: Type
}


class RMSearchVC: UIViewController {

    private let searchCategory: SearchCategory
    
    init(searchCategory: SearchCategory) {
        self.searchCategory = searchCategory
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemIndigo
    }
}
