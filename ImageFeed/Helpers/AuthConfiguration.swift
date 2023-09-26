//
//  Constants.swift
//  ImageFeed
//
//  Created by Артем Калюжин on 28.07.2023.
//

import Foundation

enum Constants {
    static let AccessKey: String = "MA7HjNsnuWCbrbfL32ReSwNR0X9trFaLv9GNrWuDp_Y"
    static let SecretKey: String = "aSrX6sFvnPuoSccN-4zjlvQfhHXeQy1x_ZZekMGrKag"
    static let RedirectURI: String = "urn:ietf:wg:oauth:2.0:oob"
    static let AccessScope: String = "public+read_user+write_likes"
    static let DefaultBaseURL = URL(string: "https://api.unsplash.com")!
    static let UnsplashAuthorizeURLString: String = "https://unsplash.com/oauth/authorize"
}

struct AuthConfiguration {
    let accessKey: String
    let secretKey: String
    let redirectURI: String
    let accessScope: String
    let defaultBaseURL: URL
    let authURLString: String
    
    init(accessKey: String, secretKey: String, redirectURI: String, accessScope: String, authURLString: String, defaultBaseURL: URL) {
        self.accessKey = accessKey
        self.secretKey = secretKey
        self.redirectURI = redirectURI
        self.accessScope = accessScope
        self.defaultBaseURL = defaultBaseURL
        self.authURLString = authURLString
    }
    
    static var standard: AuthConfiguration {
        return AuthConfiguration(accessKey: Constants.AccessKey,
                                 secretKey: Constants.SecretKey,
                                 redirectURI: Constants.RedirectURI,
                                 accessScope: Constants.AccessScope,
                                 authURLString: Constants.UnsplashAuthorizeURLString,
                                 defaultBaseURL: Constants.DefaultBaseURL)
       }
}
