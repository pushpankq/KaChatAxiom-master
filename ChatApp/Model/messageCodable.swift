//
//  message.swift
//  ChatApp
//
//  Created by Kashif Rizwan on 8/21/19.
//  Copyright © 2019 Dima Nikolaev. All rights reserved.
//

import Foundation

struct messageCodable : Codable {
    
    let date : String?
    let message : String?
    let rDel : String?
    let rid : String?
    let rName : String?
    let sName : String?
    let sDel : String?
    let sid : String?
    let type : String?
    let chatId : String?
    let duration : String?
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case message = "message"
        case rDel = "rDel"
        case rid = "rid"
        case rName = "rName"
        case sDel = "sDel"
        case sid = "sid"
        case sName = "sName"
        case type = "type"
        case chatId = "chatId"
        case duration = "duration"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        rDel = try values.decodeIfPresent(String.self, forKey: .rDel)
        rid = try values.decodeIfPresent(String.self, forKey: .rid)
        rName = try values.decodeIfPresent(String.self, forKey: .rName)
        sDel = try values.decodeIfPresent(String.self, forKey: .sDel)
        sid = try values.decodeIfPresent(String.self, forKey: .sid)
        sName = try values.decodeIfPresent(String.self, forKey: .sName)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        chatId = try values.decodeIfPresent(String.self, forKey: .chatId)
        duration = try values.decodeIfPresent(String.self, forKey: .duration)
    }
    
}
