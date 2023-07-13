//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Артем Калюжин on 13.07.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    
    @IBAction func didTapLogoutButton(_ sender: Any) {
    }
}
