//
//  GroupInfoModelRealm.swift
//  Task
//
//  Created by mohamed salah on 3/19/21.
//

import UIKit
import RealmSwift

class GroupInfoModelRealm: Object {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var _description = ""
    @objc dynamic var iconserver = ""
    @objc dynamic var iconfarm = 0
    @objc dynamic var members = ""
    @objc dynamic var datecreate = ""
    
    convenience init(groupInfo: GroupInfoModel) {
        self.init()
        self.id = groupInfo.id
        self.name = groupInfo.name.content
        self._description = groupInfo.description.content
        self.iconserver = groupInfo.iconserver
        self.iconfarm = groupInfo.iconfarm
        self.members = groupInfo.members.content
        self.datecreate = groupInfo.datecreate.content
    }
}

extension GroupInfoModelRealm: displayableGroupInfoModelProtocol {
    var date: String {
        return datecreate
    }
    
    var groupInfoDescriptionName: String {
        return _description
    }
    
    var iconUrl: String {
        if  iconserver != "0" {
            return "https://farm\(iconfarm).staticflickr.com/\(iconserver)/buddyicons/\(id).jpg"
        } else {
            return defaultIconURL
        }
    }
    
    var groupInfoName: String {
        return  name
    }
    
    var groupMembersCount: String {
        return "Memebrs: \(members)"
    }
}
