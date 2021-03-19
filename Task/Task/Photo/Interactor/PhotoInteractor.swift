//
//  PhotoInteractor.swift
//  Task
//
//  Created by mohamed salah on 3/19/21.
//

import Foundation
import Alamofire


class PhotoInteractor: PhotosPresenterToPhotoInteractorProtocol {
    
    var photosInteractorToPhotosPresenterDelegate: PhotosInteractorToPhotosPresenterProtocol?
    var page = 0
    let pageSize = 10
    
    func fetchPhotos() {
        let parameter: [String: Any] =
            ["api_key": flickerApiKey,
             "method": flickerGetImagesMethod,
             "format": "json",
             "per_page": pageSize,
             "page": page,
             "nojsoncallback": 1]
        
        AF.request(getFlickerBaseAPI,
                   method: .get,
                   parameters: parameter,
                   encoding:  URLEncoding.default,
                   headers: nil).responseDecodable(of:Root<PhotoRootModel<Photo>>.self) { (response) in
                    switch  response.result {
                    case  .success(let rootPhoto):
                        self.photosInteractorToPhotosPresenterDelegate?.photosFetchedWithList(list: rootPhoto.photo.photoList)
                        DataBaseHandler.savePhotos(rootPhoto.photo.photoList)
                        self.page += 1
                        break
                    case .failure(let error):
                        self.photosInteractorToPhotosPresenterDelegate?.photosFetchedWithList(list: DataBaseHandler.getPhotos())
                        self.photosInteractorToPhotosPresenterDelegate?.error()
                        break
                    }
                    
                   }
    }
}
