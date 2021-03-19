//
//  GroupModel.swift
//  Task
//
//  Created by mohamed salah on 3/18/21.
//

import UIKit

protocol displayableGroupModelProtocol {
    var groupName: String { get }
    var groupMembersCount: String { get }
    var iconUrl: String { get }
    var groupId: String { get }
}

struct GroupModel: Decodable {
    let id: String
    let name: String
    let iconserver: String
    let iconfarm: Int
    let members: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "nsid"
        case name = "name"
        case iconserver = "iconserver"
        case iconfarm = "iconfarm"
        case members = "members"
    }
    
}

struct GroupRoot<T: Decodable>: Decodable {
    let groups: T
    let stat: String
    
    private enum CodingKeys : String, CodingKey {
        case groups = "groups"
        case stat = "stat"
    }
}

struct GroupRootModel<D: Decodable>: Decodable {
    let perPage: Int
    let pages: Int
    let total: String
    let currentPage: Int
    let groupList: [D]
    
    private enum CodingKeys: String, CodingKey {
        case perPage = "perpage"
        case pages = "pages"
        case total = "total"
        case currentPage = "page"
        case groupList = "group"
    }
}


extension GroupModel: displayableGroupModelProtocol {
    var groupId: String {
        return id
    }
    
    
    var iconUrl: String {
        if  iconserver != "0" {
            return "https://farm\(iconfarm).staticflickr.com/\(iconserver)/buddyicons/\(id).jpg"
        } else {
            return defaultIconURL
        }
    }
    
    var groupName: String {
        return name
    }
    
    var groupMembersCount: String {
        return "Memebrs: \(members)"
    }
}
