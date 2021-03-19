//
//  PhotoRootModel.swift
//  Task
//
//  Created by mohamed salah on 3/19/21.
//

import Foundation

struct Root<T: Decodable>: Decodable {
    let photo: T
    let stat: String
    
    private enum CodingKeys : String, CodingKey {
        case photo = "photos"
        case stat = "stat"
    }
}

struct PhotoRootModel <D: Decodable>: Decodable {
    let perPage: Int
    let pages: Int
    let total: Int
    let currentPage: Int
    let photoList: [D]
    
    private enum CodingKeys: String, CodingKey {
        case perPage = "perpage"
        case pages = "pages"
        case total = "total"
        case currentPage = "page"
        case photoList = "photo"
    }
}
