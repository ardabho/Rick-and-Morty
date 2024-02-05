//
//  RMCharacterDetailVC.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 5.02.2024.
//

import UIKit

class RMCharacterDetailVC: UIViewController {

    private var viewModel: RMCharacterDetailVM!
    
    init(with viewModel: RMCharacterDetailVM) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.nameText
        
    }

}
