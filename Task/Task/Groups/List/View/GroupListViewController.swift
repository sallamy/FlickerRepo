//
//  GroupListViewController.swift
//  Task
//
//  Created by mohamed salah on 3/19/21.
//

import UIKit
import UIKit
import SVProgressHUD
import SDWebImage

class GroupListViewController: UIViewController,GroupListPresenterToGroupListViewProtocol {
    var groupListViewToGroupListPresenterProtocol: GroupListViewToGroupListPresenterProtocol?
    var listOfflickerGroups = [displayableGroupModelProtocol]()
    var loadingData = false
    var connectionError = false
    @IBOutlet weak var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.title = "Group List"
        fetchGroupList()
    }
    
    func fetchGroupList() {
        DispatchQueue.main.async {
            SVProgressHUD.show()
        }
        loadingData = true
        connectionError = false
        self.groupListViewToGroupListPresenterProtocol?.fetchGroupList()
    }
    
    func groupsFetchedWithList(list: [displayableGroupModelProtocol]) {
        self.listOfflickerGroups.append(contentsOf: list)
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

extension GroupListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.listOfflickerGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GroupCell
        let flickerDisplayInfo = self.listOfflickerGroups[indexPath.row]
        cell.groupIconImageView.sd_setImage(with: URL(string: flickerDisplayInfo.iconUrl), placeholderImage: nil)
        cell.groupNameLabel.text = flickerDisplayInfo.groupName
        cell.groupMembersContLabel.text = flickerDisplayInfo.groupMembersCount
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigationController =  self.navigationController else {
            return
        }
        self.groupListViewToGroupListPresenterProtocol?.navigateToInfoScreen(navigationConroller:navigationController , groupId: self.listOfflickerGroups[indexPath.row].groupId)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        
        if !loadingData && (maximumOffset - contentOffset <= 100)  && !connectionError{
            fetchGroupList()
        }
    }
}

class GroupCell: UITableViewCell {
    @IBOutlet weak var groupIconImageView: UIImageView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupMembersContLabel: UILabel!
}
