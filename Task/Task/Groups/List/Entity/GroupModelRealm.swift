//
//  GroupModelRealm.swift
//  Task
//
//  Created by mohamed salah on 3/18/21.
//

import UIKit
import RealmSwift

class GroupModelRealm: Object {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var iconserver = ""
    @objc dynamic var iconfarm = 0
    @objc dynamic var members = ""
    
    convenience init(group: GroupModel) {
        self.init()
        self.id = group.id
        self.name = group.name
        self.iconserver = group.iconserver
        self.iconfarm = group.iconfarm
        self.members = group.members
    }
}

extension GroupModelRealm: displayableGroupModelProtocol {
    var groupId: String {
        self.id
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
