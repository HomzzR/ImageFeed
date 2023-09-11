//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Артем Калюжин on 13.07.2023.
//

import UIKit
import Kingfisher
import ProgressHUD
import SwiftKeychainWrapper
import WebKit

final class ProfileViewController: UIViewController {
    // MARK: - Private properties
    
    private var avatarImage: UIImageView!
    private var nameLabel: UILabel!
    private var loginLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var logoutButton: UIButton!
    
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    private var profileImageServiceObserver: NSObjectProtocol?
    private let tokenStorage = OAuth2TokenStorage()
    
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
        
        updateProfileDetails(profile: profileService.profile)
        updateAvatar()
        checkForAvatarUpdates()
        view.backgroundColor = .ypBlack
    }
    
    // MARK: - Private functions
    
    private func updateProfileDetails(profile: Profile?) {
        if let profile = profile {
            nameLabel.text = profile.name
            loginLabel.text = profile.loginName
            descriptionLabel.text = profile.bio
        } else {
            nameLabel.text = "Error"
            loginLabel.text = "Error"
            descriptionLabel.text = "Error"
        }
    }
    
    private func updateAvatar() {
        guard let profileImageURL = profileImageService.avatarURL,
              let url = URL(string: profileImageURL)
        else { return }
        let placeholderImage = UIImage(systemName: "avatar")
        let processor = RoundCornerImageProcessor(radius: .point(50))
        avatarImage.kf.setImage(with: url, placeholder: placeholderImage, options: [.processor(processor)])
    }
    
    private func checkForAvatarUpdates() {
        profileImageServiceObserver = NotificationCenter.default.addObserver(
            forName: ProfileImageService.didChangeNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            guard let self = self else { return }
            self.updateAvatar()
        }
        updateAvatar()
    }
    
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
        nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16).isActive = true
    }
    
    // Логин
    private func loginLabelView(safeArea: UILayoutGuide) {
        loginLabel = UILabel()
        loginLabel.textColor = .ypGray
        loginLabel.text = "@ekaterina_nov"
        loginLabel.font = .systemFont(ofSize: 13, weight: .regular)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginLabel)
        
        loginLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        loginLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        loginLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
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
        descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
    }
    
    // Кнопка выхода из профиля
    private func logoutButtonView(safeArea: UILayoutGuide) {
        logoutButton = UIButton.systemButton(
            with: (UIImage(named: "logout_button") ?? UIImage()).withRenderingMode(.alwaysOriginal),
            target: self,
            action: nil
        )
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.addTarget(nil, action: #selector(logoutButtonTapped), for: .touchUpInside)
        view.addSubview(logoutButton)
        logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        logoutButton.centerYAnchor.constraint(equalTo: avatarImage.centerYAnchor).isActive = true
    }
    
    private func profileLogout() {
        tokenStorage.deleteToken()
        UIBlockingProgressHUD.show()
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
        let window = UIApplication.shared.windows.first
        let splashViewController = SplashViewController()
        window?.rootViewController = splashViewController
        UIBlockingProgressHUD.dismiss()
    }
    
    @objc private func logoutButtonTapped() {
        let alert = UIAlertController(title: "Пока, пока!", message: "Уверены что хотите выйти?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Да", style: .default) { [weak self] _ in
            guard let self = self else {return}
            self.profileLogout()
        }
        let noAction = UIAlertAction(title: "Нет", style: .cancel, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert, animated: true, completion: nil)
    }
}
