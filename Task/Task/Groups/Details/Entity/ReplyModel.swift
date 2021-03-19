//
//  ReplyModel.swift
//  Task
//
//  Created by mohamed salah on 3/19/21.
//

import UIKit

protocol displayableReplyModelProtocol: GroupInfoProtocol {
    var replyMessage: String { get }
    var authorName: String { get }
    var iconUrl: String { get }
    var date: String { get }
}

class ReplyModel: Decodable {
    let id: String
    let message: Content
    let authorname: String
    let iconserver: String
    let iconfarm: Int
    let datecreate: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case message = "message"
        case iconserver = "iconserver"
        case iconfarm = "iconfarm"
        case authorname = "authorname"
        case datecreate = "datecreate"
    }
}

struct ReplyRoot<T: Decodable>: Decodable {
    let replies: T
    let stat: String
    
    private enum CodingKeys : String, CodingKey {
        case replies = "replies"
        case stat = "stat"
    }
}

struct ReplyModelRoot<D: Decodable>: Decodable {
    let reply: [D]?
    
    private enum CodingKeys: String, CodingKey {
        case reply = "reply"
    }
}

extension ReplyModel: displayableReplyModelProtocol {
    var replyMessage: String {
        return message.content
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
