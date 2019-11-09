//
//  messages.swift
//  ChatApp
//
//  Created by Kashif Rizwan on 8/21/19.
//  Copyright © 2019 Dima Nikolaev. All rights reserved.
//

import Foundation

struct message {
    var date : String
    var message : String
    var rDel : String
    var rid : String
    var rName : String
    var sDel : String
    var sid : String
    var sName : String
    var type : String
    var messageId : String
    var chatId : String
    var duration : String
    
    init(date : String, message : String, rDel : String, rid : String, rName : String, sDel : String, sid : String, sName : String, type : String, messageId : String, chatId : String, duration : String) {
        self.date = date
        self.message = message
        self.rDel = rDel
        self.rid = rid
        self.rName = rName
        self.sDel = sDel
        self.sid = sid
        self.sName = sName
        self.type = type
        self.messageId = messageId
        self.chatId = chatId
        self.duration = duration
    }
}
