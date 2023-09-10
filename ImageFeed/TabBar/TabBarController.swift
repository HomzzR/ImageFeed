//
//  TabBarController.swift
//  ImageFeed
//
//  Created by Артем Калюжин on 10.09.2023.
//

import UIKit
 
final class TabBarController: UITabBarController {
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .ypWhite
        tabBar.barTintColor = .ypBlack
        tabBar.isTranslucent = false
        
        let imagesListViewController = ImagesListViewController()
        imagesListViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "tab_editorial_active"),
            selectedImage: nil)
            
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "tab_profile_active"),
            selectedImage: nil)
        
        self.viewControllers = [imagesListViewController, profileViewController]
    }
}
