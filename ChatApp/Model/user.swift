//
//  user.swift
//  ChatApp
//
//  Created by Kashif Rizwan on 8/28/19.
//  Copyright © 2019 Dima Nikolaev. All rights reserved.
//

import Foundation

struct user {
    let email : String
    let image : String
    let isActive : Bool
    let name : String
    let userId : String
    
    init(email : String, image : String, isActive : String, name : String, userId: String) {
        self.email = email
        self.image = image
        if isActive == "true"{
            self.isActive = true
        }else{
            self.isActive = false
        }
        self.name = name
        self.userId = userId
    }
}
