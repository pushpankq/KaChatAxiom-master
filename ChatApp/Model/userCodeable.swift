//
//  userCodeable.swift
//  ChatApp
//
//  Created by Kashif Rizwan on 8/28/19.
//  Copyright © 2019 Dima Nikolaev. All rights reserved.
//

import Foundation

struct userCodable : Codable {
    
    let email : String?
    let image : String?
    let isActive : String?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case image = "image"
        case isActive = "isActive"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}

