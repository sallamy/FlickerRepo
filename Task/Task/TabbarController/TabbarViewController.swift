//
//  TabbarViewController.swift
//  Task
//
//  Created by mohamed salah on 3/19/21.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        PhotosRouter.createModule(photosViewController: self.viewControllers?.first as! PhotosViewController)
        guard let navigation = self.viewControllers?.last as? UINavigationController , let groupViewController = navigation.viewControllers.first as? GroupListViewController else {
          return
        }
     
        GroupsRouter.createGroupModule(groupsViewController: groupViewController)
            // Do any additional setup after loading the view.
    }

}
