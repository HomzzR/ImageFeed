//
//  ProfileService.swift
//  ImageFeed
//
//  Created by Артем Калюжин on 04.09.2023.
//

import UIKit

final class ProfileService {
    
}

struct ProfileResult: Codable {
    let username: String
    let firstName: String
    let lastName: String?
    let bio: String?
    
    enum CodingKeys: String, CodingKey {
        case username
        case firstName = "first_name"
        case lastName = "last_name"
        case bio = "bio"
    }
}
