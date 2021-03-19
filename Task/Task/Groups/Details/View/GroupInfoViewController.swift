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

class GroupInfoViewController: UIViewController, GroupInfoPresenterToGroupInfoViewProtocol {

    var groupInfoViewToGroupInfoPresenterDelegate: GroupInfoViewToGroupInfoPresenterProtocol?
    var groupInfoList = [GroupInfoProtocol]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  fetchGroupList()
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableView.automaticDimension
        self.fetchGroupInfo()
    }
    
    
    
    func fetchGroupInfo(){
        DispatchQueue.main.async {
            SVProgressHUD.show()
        }
        self.groupInfoViewToGroupInfoPresenterDelegate?.fetchGroupInfo()
    }
    
    func groupInfoFetched(list: [GroupInfoProtocol]) {
        self.groupInfoList = list
        DispatchQueue.main.async {
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        }
    }
    
    func error() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
}

extension GroupInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.groupInfoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let groupInfoItem = self.groupInfoList[indexPath.row]
        if let groupInfoModel = groupInfoItem as? displayableGroupInfoModelProtocol {
            return dequeueGroupInfoCell(with: groupInfoModel, indexPath: indexPath)
        } else if let topic = groupInfoItem as? displayableTopicModelProtocol {
            return dequeueGroupInfoTopicCell(with: topic, indexPath: indexPath)
        } else if let reply = groupInfoItem as? displayableReplyModelProtocol {
            return dequeueGroupInfoTopicCell(with: reply, indexPath: indexPath)
        }
        
        return UITableViewCell()
    }
    func dequeueGroupInfoCell(with groupInfo: displayableGroupInfoModelProtocol, indexPath: IndexPath) -> GroupInfoCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupInfoCell", for: indexPath) as! GroupInfoCell
        cell.groupIconImageView.sd_setImage(with: URL(string: groupInfo.iconUrl), placeholderImage: nil)
        cell.groupNameLabel.text = groupInfo.groupInfoName
        cell.groupMembersContLabel.text = groupInfo.groupMembersCount
        cell.groupDescriptionLabel.text = groupInfo.groupInfoDescriptionName
        
        return cell
    }
    
    func dequeueGroupInfoTopicCell(with topic: displayableTopicModelProtocol, indexPath: IndexPath) -> GroupInfoTopicCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupInfoTopicCell", for: indexPath) as! GroupInfoTopicCell
        
        cell.topicAuthorNameLabel.text = topic.authorName
        cell.topicDateLabel.text = topic.date
        cell.topicRepliesContLabel.text = topic.countOfReplies
        cell.topicSubjectLabel.text = topic.topicSubject
        
        return cell
    }
    
    func dequeueGroupInfoTopicCell(with reply: displayableReplyModelProtocol, indexPath: IndexPath) -> TopicReplyCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicReplyCell", for: indexPath) as! TopicReplyCell
        cell.replyAuthorNameLabel.text = reply.authorName
        cell.replyDateLabel.text = reply.date
        cell.replyMessageLabel.text = reply.replyMessage
       // cell.authorIconImageView.sd_setImage(with: URL(string: reply.iconUrl), placeholderImage: nil)
        
        return cell
    }
    
}

class GroupInfoCell: UITableViewCell {
    @IBOutlet weak var groupIconImageView: UIImageView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupMembersContLabel: UILabel!
    @IBOutlet weak var groupDescriptionLabel: UILabel!
}

class GroupInfoTopicCell: UITableViewCell {
    @IBOutlet weak var topicAuthorNameLabel: UILabel!
    @IBOutlet weak var topicRepliesContLabel: UILabel!
    @IBOutlet weak var topicSubjectLabel: UILabel!
    @IBOutlet weak var topicDateLabel: UILabel!
}

class TopicReplyCell: UITableViewCell {
    @IBOutlet weak var replyAuthorNameLabel: UILabel!
    @IBOutlet weak var authorIconImageView: UIImageView!
    @IBOutlet weak var replyMessageLabel: UILabel!
    @IBOutlet weak var replyDateLabel: UILabel!
}
