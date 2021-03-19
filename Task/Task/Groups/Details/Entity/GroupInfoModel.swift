//
//  GroupModel.swift
//  Task
//
//  Created by mohamed salah on 3/18/21.
//

import UIKit
protocol GroupInfoProtocol { }

protocol displayableGroupInfoModelProtocol: GroupInfoProtocol {
    var groupInfoName: String { get }
    var groupInfoDescriptionName: String { get }
    var groupMembersCount: String { get }
    var iconUrl: String { get }
    var date: String { get }
}

struct GroupInfoModel: Decodable {
    let id: String
    let name: Content
    let description: Content
    let iconserver: String
    let iconfarm: Int
    let members: Content
    let datecreate:Content
    
    private enum CodingKeys: String, CodingKey {
        case id = "nsid"
        case name = "name"
        case iconserver = "iconserver"
        case iconfarm = "iconfarm"
        case members = "members"
        case description = "description"
        case datecreate = "datecreate"
    }
    
}

struct Content:Decodable {
    let content: String
    private enum CodingKeys: String, CodingKey {
        case content = "_content"
    }
    
}

struct GroupInfoRoot<T: Decodable>: Decodable {
    let groups: T
    let stat: String
    
    private enum CodingKeys : String, CodingKey {
        case groups = "group"
        case stat = "stat"
    }
}

extension GroupInfoModel: displayableGroupInfoModelProtocol {
    var date: String {
        return datecreate.content
    }
    
    var groupInfoDescriptionName: String {
        return description.content
    }
    
    var iconUrl: String {
        if  iconserver != "0" {
            return "https://farm\(iconfarm).staticflickr.com/\(iconserver)/buddyicons/\(id).jpg"
        } else {
            return defaultIconURL
        }
    }
    
    var groupInfoName: String {
        return  name.content
    }
    
    var groupMembersCount: String {
        return "Memebrs: \(members.content)"
    }
}
