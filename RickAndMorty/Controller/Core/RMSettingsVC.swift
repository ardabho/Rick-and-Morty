//
//  RMSettingsVC.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 30.01.2024.
//

import UIKit
import SwiftUI
import SafariServices
import StoreKit

class RMSettingsVC: UIViewController {
    
    private var settingsSwiftUIController: UIHostingController<RMSettingsView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Settings"
        addSwiftUIController()
    }
    
    
    private func addSwiftUIController() {
        let settingsSwiftUIController = UIHostingController(rootView: RMSettingsView(viewModel: RMSettingsViewVM(
            cellViewModels: RMSettingsOption.allCases.compactMap({
                return RMSettingsCellVM(type: $0) { [weak self] option in
                    self?.handleTap(option: option)
                }
            })
        )))
        
        addChild(settingsSwiftUIController)
        settingsSwiftUIController.didMove(toParent: self)
        
        view.addSubview(settingsSwiftUIController.view)
        settingsSwiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        settingsSwiftUIController.view.pinToEdgesWithSafeAreaLayoutGuide(of: view)
        
        self.settingsSwiftUIController = settingsSwiftUIController
    }
    
    
    private func handleTap(option: RMSettingsOption) {
        guard Thread.current.isMainThread else { return }
        
        if let url = option.targetURL {
            let vc = SFSafariViewController(url: url)
            navigationController?.present(vc, animated: true)
            
        } else if option == .rateApp {
            if let windowScene = view.window?.windowScene {
                SKStoreReviewController.requestReview(in: windowScene)
            }
        }
        
        
    }

}
