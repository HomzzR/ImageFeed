//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Артем Калюжин on 13.07.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - Private properties & IBOutlet
    
    private var avatarImage: UIImageView!
    private var nameLabel: UILabel!
    private var loginLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var logoutButton: UIButton!
    
    
    // MARK: - Light content
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatarImageView(safeArea: view.safeAreaLayoutGuide)
        nameLabelView(safeArea: view.safeAreaLayoutGuide)
        loginLabelView(safeArea: view.safeAreaLayoutGuide)
        descriptionLabelView(safeArea: view.safeAreaLayoutGuide)
        logoutButtonView(safeArea: view.safeAreaLayoutGuide)
    }
    
    // MARK: - Private functions
    
    // Аватар
    private func avatarImageView(safeArea: UILayoutGuide) {
        avatarImage = UIImageView()
        avatarImage.image = UIImage(named: "avatar")
        avatarImage.tintColor = .ypGray
        avatarImage.layer.cornerRadius = 35
        avatarImage.clipsToBounds = true
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(avatarImage)
        
        avatarImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        avatarImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        avatarImage.heightAnchor.constraint(equalToConstant: 70).isActive = true
        avatarImage.widthAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    // Имя пользователя
    private func nameLabelView(safeArea: UILayoutGuide) {
        nameLabel = UILabel()
        nameLabel.textColor = .ypWhite
        nameLabel.text = "Екатерина Новикова"
        nameLabel.font = .boldSystemFont(ofSize: 23)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        nameLabel.leadingAnchor.constraint(equalTo: avatarImage.leadingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 8).isActive = true
    }
    
    // Логин
    private func loginLabelView(safeArea: UILayoutGuide) {
        loginLabel = UILabel()
        loginLabel.textColor = .ypGray
        loginLabel.text = "@ekaterina_nov"
        loginLabel.font = .systemFont(ofSize: 13)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginLabel)
        
        loginLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        loginLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
    }
    
    // Описание
    private func descriptionLabelView(safeArea: UILayoutGuide) {
        descriptionLabel = UILabel()
        descriptionLabel.textColor = .ypWhite
        descriptionLabel.text = "Hello, world!"
        descriptionLabel.font = .systemFont(ofSize: 13, weight: .regular)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
        
        descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 8).isActive = true
    }
    
    // Кнопка выхода из профиля
    private func logoutButtonView(safeArea: UILayoutGuide) {
        logoutButton = UIButton.systemButton(
            with: UIImage(named: "logout_button") ?? UIImage().withRenderingMode(.alwaysOriginal),
            target: self,
            action: nil
        )
        logoutButton.tintColor = .ypRed
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutButton)
        
        logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        logoutButton.centerYAnchor.constraint(equalTo: avatarImage.centerYAnchor).isActive = true
    }
}
