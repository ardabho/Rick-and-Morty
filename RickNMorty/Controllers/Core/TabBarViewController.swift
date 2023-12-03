//
//  ViewController.swift
//  test
//
//  Created by Arda Büyükhatipoğlu on 30.11.2023.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    //View controllers
    private lazy var charactersVC: UINavigationController = {
        let NC = UINavigationController(rootViewController: CharactersViewController())
        NC.navigationBar.prefersLargeTitles = true
        NC.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "face.dashed"), selectedImage: UIImage(systemName: "face.dashed.fill"))
        return NC
    }()
    
    private lazy var locationsVC: UINavigationController = {
        let NC = UINavigationController(rootViewController: LocationsViewController())
        NC.navigationBar.prefersLargeTitles = true
        NC.tabBarItem = UITabBarItem(title: "Location", image: UIImage(systemName: "globe.desk"), selectedImage: UIImage(systemName: "globe.desk.fill"))
        return NC
    }()
    
    private lazy var episodesVC: UINavigationController = {
        let NC = UINavigationController(rootViewController: EpisodesViewController())
        NC.navigationBar.prefersLargeTitles = true
        NC.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "tv"), selectedImage: UIImage(systemName: "tv.inset.filled"))
        return NC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
        configureNavBar()
        setViewControllers()
    }
    
    private func configureNavBar() {
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        UINavigationBar.appearance().tintColor = UIColor.label
    }
    
    private func configureTabBar() {
        tabBar.tintColor = .label
        tabBar.unselectedItemTintColor = .secondaryLabel
    }
    
    private func setViewControllers() {
        setViewControllers([charactersVC,locationsVC,episodesVC], animated: false)
    }

}
