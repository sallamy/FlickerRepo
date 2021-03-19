//
//  Photo.swift
//  Task
//
//  Created by mohamed salah on 3/19/21.
//

import Foundation

protocol displayablePhotoProtocol {
    var ownerName: String { get }
    var photoUrl: String { get }
    var title: String { get }
}

struct Photo: Decodable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let title: String
    
    private enum CodingKeys : String, CodingKey {
        case id = "id"
        case owner = "owner"
        case secret = "secret"
        case server = "server"
        case title = "title"
    }
}

extension Photo: displayablePhotoProtocol {
    var ownerName: String {
        return owner
    }
    
    var photoUrl: String {
        return "https://live.staticflickr.com/\(server)/\(id)_\(secret).jpg"
    }
}


