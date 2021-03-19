//
//  DataBaseHandler.swift
//  Task
//
//  Created by mohamed salah on 3/19/21.
//

import UIKit
import RealmSwift

class DataBaseHandler {
    
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
