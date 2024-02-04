//
//  ViewController.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 30.01.2024.
//

import UIKit

final class RMTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }

    
    private func configureTabBar() {
        tabBar.tintColor = .label
        tabBar.unselectedItemTintColor = .secondaryLabel
        
        setViewControllers([createCharacterNC(), createLocationNC(), createEpisodeNC(), createSettingsNC()], animated: true)
    }
    
    
    private func createCharacterNC() -> UINavigationController{
        let characterVC = RMCharacterVC()
        characterVC.navigationItem.largeTitleDisplayMode = .automatic
        characterVC.title = "Characters"
        
        let characterNC = UINavigationController(rootViewController: characterVC)
        characterNC.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        characterNC.navigationBar.prefersLargeTitles = true
        
        return characterNC
    }
    
    
    private func createLocationNC() -> UINavigationController {
        let locationVC = RMLocationVC()
        locationVC.navigationItem.largeTitleDisplayMode = .automatic
        locationVC.title = "Locations"
        
        let locationNC = UINavigationController(rootViewController: locationVC)
        locationNC.tabBarItem = UITabBarItem(title: "Locations", image: UIImage(systemName: "globe.desk"), selectedImage: UIImage(systemName: "globe.desk.fill"))
        locationNC.navigationBar.prefersLargeTitles = true
        
        return locationNC

    }
    
    
    private func createEpisodeNC() -> UINavigationController {
        let episodeVC = RMLocationVC()
        episodeVC.navigationItem.largeTitleDisplayMode = .automatic
        episodeVC.title = "Episodes"
        
        let episodeNC = UINavigationController(rootViewController: episodeVC)
        episodeNC.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "tv"), selectedImage: UIImage(systemName: "tv.inset.filled"))
        episodeNC.navigationBar.prefersLargeTitles = true
        
        return episodeNC
    }
    
    
    private func createSettingsNC() -> UINavigationController {
        let settingsVC = RMLocationVC()
        settingsVC.navigationItem.largeTitleDisplayMode = .automatic
        settingsVC.title = "Settings"
        
        let settingsNC = UINavigationController(rootViewController: settingsVC)
        settingsNC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape.2"), selectedImage: UIImage(systemName: "gearshape.2.fill"))
        settingsNC.navigationBar.prefersLargeTitles = true
        
        return settingsNC
    }
}
