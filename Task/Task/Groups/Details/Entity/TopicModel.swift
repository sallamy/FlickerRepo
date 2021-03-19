//
//  TopicModel.swift
//  Task
//
//  Created by mohamed salah on 3/18/21.
//

import UIKit

protocol displayableTopicModelProtocol: GroupInfoProtocol {
    var topicSubject: String { get }
    var authorName: String { get }
    var countOfReplies: String { get }
    var iconUrl: String { get }
    var date: String { get }
}

class TopicModel: Decodable {
    
    let id: String
    let subject: String
    let authorname: String
    let iconserver: String
    let iconfarm: Int
    let count_replies: String
    let datecreate: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case subject = "subject"
        case iconserver = "iconserver"
        case iconfarm = "iconfarm"
        case authorname = "authorname"
        case count_replies = "count_replies"
        case datecreate = "datecreate"
    }
}

struct TopicRoot<T: Decodable>: Decodable {
    let topics: T
    let stat: String
    
    private enum CodingKeys : String, CodingKey {
        case topics = "topics"
        case stat = "stat"
    }
}

struct TopicModelRoot<D: Decodable>: Decodable {
    let topic: [D]?
    
    private enum CodingKeys: String, CodingKey {
        case topic = "topic"
    }
}

extension TopicModel: displayableTopicModelProtocol {
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
