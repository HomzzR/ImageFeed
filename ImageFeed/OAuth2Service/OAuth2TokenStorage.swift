//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Артем Калюжин on 31.07.2023.
//

import UIKit

final class OAuth2TokenStorage {
    
    private let userDefaults = UserDefaults.standard
    
    var token: String?
    {
        get {
            return userDefaults.string(forKey: "token")
        }
        set {
            return userDefaults.set(newValue, forKey: "token")
        }
    }
}
