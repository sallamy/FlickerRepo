//
//  PhotoRealm.swift
//  Task
//
//  Created by mohamed salah on 3/19/21.
//

import UIKit
import RealmSwift

class PhotoRealm: Object {
    @objc dynamic var id = ""
    @objc dynamic var owner = ""
    @objc dynamic var secret = ""
    @objc dynamic var server = ""
    @objc dynamic var title = ""
    
    convenience init(photo: Photo) {
        self.init()
        self.id = photo.id
        self.owner = photo.owner
        self.secret = photo.secret
        self.server = photo.server
        self.title = photo.title
    }
}

extension PhotoRealm: displayablePhotoProtocol {
    var ownerName: String {
        return owner
    }
    
    var photoUrl: String {
        return "https://live.staticflickr.com/\(server)/\(id)_\(secret).jpg"
    }
}
