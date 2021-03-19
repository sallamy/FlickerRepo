//
//  PhotoProtocols.swift
//  Task
//
//  Created by mohamed salah on 3/19/21.
//

import Foundation

protocol ViewPhotosToPresenterProtocol: class {
    var photosPresenterToPhotoViewDelegate: PhotosPresenterToPhotoViewProtocol? { get set }
    var photosPresenterToRouterDelegate: PhotosPresenterToRouterProtocol? {get set}
    var photosPresenterToPhotoInteractorDelegate: PhotosPresenterToPhotoInteractorProtocol? { get set }
    func fetchPhotos()
    func error()
    
}

protocol PhotosPresenterToPhotoInteractorProtocol: class {
    var photosInteractorToPhotosPresenterDelegate: PhotosInteractorToPhotosPresenterProtocol? { get set }
    func fetchPhotos()
    
}

protocol PhotosPresenterToRouterProtocol: class {
    static func createModule(photosViewController: PhotosViewController)
}

protocol PhotosPresenterToPhotoViewProtocol: class {
    var viewPhotosToPresenterDelegate: ViewPhotosToPresenterProtocol?  { get set }
    func photosFetchedWithList(list:[displayablePhotoProtocol])
    func error()
}

protocol PhotosInteractorToPhotosPresenterProtocol: class {
    func photosFetchedWithList(list:[displayablePhotoProtocol])
    func error()
}
