//
//  ReplyModelRealm.swift
//  Task
//
//  Created by mohamed salah on 3/19/21.
//

import UIKit
import RealmSwift

class ReplyModelRealm: Object {
    @objc dynamic var id = ""
    @objc dynamic var topicId = ""
    @objc dynamic var authorname = ""
    @objc dynamic var iconserver = ""
    @objc dynamic var iconfarm = 0
    @objc dynamic var datecreate = ""
    @objc dynamic var message = ""
    
    convenience init(reply: ReplyModel, topicId: String) {
        self.init()
        self.id = reply.id
        self.topicId = topicId
        self.authorname = reply.authorname
        self.iconserver = reply.iconserver
        self.iconfarm = reply.iconfarm
        self.message = reply.message.content
        self.datecreate = reply.datecreate
    }
}

extension ReplyModelRealm: displayableReplyModelProtocol {
    var replyMessage: String {
        return message
    }
    
    var authorName: String {
        return authorname
    }
    
    var iconUrl: String {
        if  iconserver != "0" {
            return "https://farm\(iconfarm).staticflickr.com/\(iconserver)/buddyicons/\(id).jpg"
        } else {
            return defaultIconURL
        }
    }
    
    var date: String {
        return Double(datecreate)?.dateFormatted ?? ""
    }
}
