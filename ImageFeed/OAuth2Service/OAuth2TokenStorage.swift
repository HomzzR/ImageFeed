//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Артем Калюжин on 31.07.2023.
//

import UIKit
import SwiftKeychainWrapper

final class OAuth2TokenStorage {
    // MARK: - Properties
    
    private let keyChainStorage = KeychainWrapper.standard

    var token: String? {
        get {
            keyChainStorage.string(forKey: .tokenKey)
        }
        set {
            if let token = newValue {
                keyChainStorage.set(token, forKey: .tokenKey)
            } else {
                keyChainStorage.removeObject(forKey: .tokenKey)
            }
        }
    }
    
    func deleteToken() {
        keyChainStorage.remove(forKey: "bearerToken")
    }
}

// MARK: - Extension

extension String {
    static let tokenKey = "bearerToken"
}
