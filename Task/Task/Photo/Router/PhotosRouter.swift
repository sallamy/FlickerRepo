//
//  File.swift
//  Task
//
//  Created by mohamed salah on 3/19/21.
//

import Foundation

class PhotosRouter: PhotosPresenterToRouterProtocol {
    
    static func createModule(photosViewController: PhotosViewController) {
      
        let presenter = PhotosPresenter()
        let interactor = PhotoInteractor()
        let router = PhotosRouter()
        presenter.photosPresenterToRouterDelegate = router
        presenter.photosPresenterToPhotoInteractorDelegate = interactor
        presenter.photosPresenterToPhotoViewDelegate = photosViewController
        interactor.photosInteractorToPhotosPresenterDelegate = presenter
        photosViewController.viewPhotosToPresenterDelegate = presenter
    }
}
