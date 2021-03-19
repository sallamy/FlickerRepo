//
//  TopicModelRealm.swift
//  Task
//
//  Created by mohamed salah on 3/19/21.
//

import UIKit
import RealmSwift

class TopicModelRealm: Object {
    @objc dynamic var id = ""
    @objc dynamic var groupId = ""
    @objc dynamic var subject = ""
    @objc dynamic var authorname = ""
    @objc dynamic var iconserver = ""
    @objc dynamic var iconfarm = 0
    @objc dynamic var count_replies = ""
    @objc dynamic var datecreate = ""
    
    convenience init(topic: TopicModel, groupId: String) {
        self.init()
        self.id = topic.id
        self.groupId = groupId
        self.subject = topic.subject
        self.authorname = topic.authorname
        self.iconserver = topic.iconserver
        self.iconfarm = topic.iconfarm
        self.count_replies = topic.count_replies
        self.datecreate = topic.datecreate
    }
}

extension TopicModelRealm: displayableTopicModelProtocol {
    var topicId: String {
        self.id
    }
    
    var topicSubject: String {
        return subject
    }
    
    var authorName: String {
        return "Author:\(authorname)"
    }
    
    var countOfReplies: String {
        return "Replies: \(count_replies)"
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
