//
//  PhotosPresenter.swift
//  Task
//
//  Created by mohamed salah on 3/19/21.
//

import Foundation

class PhotosPresenter: ViewPhotosToPresenterProtocol,PhotosInteractorToPhotosPresenterProtocol {
  
    var photosPresenterToPhotoViewDelegate: PhotosPresenterToPhotoViewProtocol?
    var photosPresenterToRouterDelegate: PhotosPresenterToRouterProtocol?
    var photosPresenterToPhotoInteractorDelegate: PhotosPresenterToPhotoInteractorProtocol?
   
    func fetchPhotos() {
        self.photosPresenterToPhotoInteractorDelegate?.fetchPhotos()
    }
    
    func photosFetchedWithList(list: [displayablePhotoProtocol]) {
        self.photosPresenterToPhotoViewDelegate?.photosFetchedWithList(list: list)
    }
    
    func error() {
        self.photosPresenterToPhotoViewDelegate?.error()
    }
}
