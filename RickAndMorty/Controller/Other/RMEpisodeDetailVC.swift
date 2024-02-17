//
//  RMEpisodeDetailVC.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 16.02.2024.
//

import UIKit

class RMEpisodeDetailVC: UIViewController {

    private let viewModel: RMEpisodeDetailVM
    
    
    init(url: URL?) {
        self.viewModel = RMEpisodeDetailVM(url: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        view.backgroundColor = .systemGreen
    }
    
    
    
}
