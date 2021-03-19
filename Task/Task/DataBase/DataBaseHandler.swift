//
//  DataBaseHandler.swift
//  Task
//
//  Created by mohamed salah on 3/19/21.
//

import UIKit
import RealmSwift

class DataBaseHandler {
    
    class func saveGroupInfo(_ groupInfo: GroupInfoModel) {
        let realm = try! Realm()
        self.deleteOldGroupInfo(groupId: groupInfo.id)
        try! realm.write() { // 2
            let groupInfoRealm = GroupInfoModelRealm(groupInfo: groupInfo)
            realm.add(groupInfoRealm)
        }
    }
    
    class func deleteOldGroupInfo(groupId: String) {
        if let group = self.getGroupInfo(with: groupId) {
            let realm = try! Realm()
            try! realm.write() { // 2
                realm.delete(group)
            }
        }
    }
    
    class func saveTopic(_ topic: TopicModel, groupId: String) {
        let realm = try! Realm()
        deleteOldTopic(groupId: groupId)
        try! realm.write() { // 2
            let topicRealm = TopicModelRealm(topic: topic, groupId: groupId)
            realm.add(topicRealm)
        }
    }
    
    class func deleteOldTopic(groupId: String) {
        if let topic = self.getTopic(with: groupId) {
            let realm = try! Realm()
            try! realm.write() { // 2
                realm.delete(topic)
            }
        }
    }
    
    class func saveReplies(_ list: [ReplyModel], topicId:String) {
        let realm = try! Realm()
        deleteOldReplies(topicId: topicId)
        try! realm.write() { // 2
            for reply in list { // 4
                let replyRealm = ReplyModelRealm(reply: reply, topicId: topicId)
                realm.add(replyRealm)
            }
        }
    }
    
    class func deleteOldReplies(topicId: String) {
        if let replies = self.getReply(with: topicId) {
            let realm = try! Realm()
            try! realm.write() { // 2
                realm.delete(replies)
            }
        }
    }
    
    class func getGroupInfo(with _id: String) -> GroupInfoModelRealm? {
        let realm = try! Realm()
        return realm.objects(GroupInfoModelRealm.self).filter(NSPredicate(format: "id == %@", _id)).first
    }
    
    class func getTopic(with group_id: String) -> TopicModelRealm? {
        let realm = try! Realm()
        return realm.objects(TopicModelRealm.self).filter(NSPredicate(format: "groupId == %@", group_id)).first
    }
    
    class func getReply(with topic_id: String) -> [ReplyModelRealm]? {
        let realm = try! Realm()
        return realm.objects(ReplyModelRealm.self).filter(NSPredicate(format: "topicId == %@", topic_id)).toArray(ofType: ReplyModelRealm.self)
    }
    
    class func savePhotos(_ list: [Photo]) {
        let realm = try! Realm()
        try! realm.write() { // 2
            for photo in list { // 4
                let photoRealm = PhotoRealm(photo: photo)
                realm.add(photoRealm)
            }
        }
    }
    
    class func getGroupList() -> [GroupModelRealm] {
        let realm = try! Realm()
        return realm.objects(GroupModelRealm.self).toArray(ofType: GroupModelRealm.self)
    }
    
    class func saveGroupList(_ list: [GroupModel]) {
        let realm = try! Realm()
        try! realm.write() { // 2
            for group in list { // 4
                let photoRealm = GroupModelRealm(group: group)
                realm.add(photoRealm)
            }
        }
    }
    
    class func getPhotos() -> [PhotoRealm] {
        let realm = try! Realm()
        return realm.objects(PhotoRealm.self).toArray(ofType: PhotoRealm.self)
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        
        return array
    }
}
