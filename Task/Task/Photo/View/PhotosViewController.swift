//
//  PhotosViewController.swift
//  Task
//
//  Created by mohamed salah on 3/19/21.
//

import Foundation
import UIKit
import SVProgressHUD
import SDWebImage

class PhotosViewController: UIViewController,PhotosPresenterToPhotoViewProtocol {
    
    var viewPhotosToPresenterDelegate: ViewPhotosToPresenterProtocol?
    var listOfflickerPhotos = [displayablePhotoProtocol]()
    var loadingData = false
    var connectionError = false
    
    @IBOutlet weak var tableView: UITableView?
    
    override func viewDidLoad() {
        fetchPhots()
        
    }
    
    func fetchPhots() {
        DispatchQueue.main.async {
            SVProgressHUD.show()
        }
        loadingData = true
        connectionError = false
        viewPhotosToPresenterDelegate?.fetchPhotos()
    }
    
    func photosFetchedWithList(list: [displayablePhotoProtocol]) {
        self.listOfflickerPhotos.append(contentsOf: list)
        self.tableView?.reloadData()
        loadingData = false
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
    func error() {
        loadingData = false
        connectionError = true
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
}

extension PhotosViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.listOfflickerPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PhotoCell
        let flickerDisplayInfo = self.listOfflickerPhotos[indexPath.row]
        cell.flickerImageView.sd_setImage(with: URL(string: flickerDisplayInfo.photoUrl), placeholderImage: nil)
        cell.ownerNameLabel.text = flickerDisplayInfo.ownerName
        cell.imageTitleLabel.text = flickerDisplayInfo.title
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        
        if !loadingData && (maximumOffset - contentOffset <= 100)  && !connectionError{
            fetchPhots()
        }
    }
}

class PhotoCell: UITableViewCell {
    @IBOutlet weak var flickerImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var imageTitleLabel: UILabel!
}
