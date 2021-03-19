//
//  GoupListInteractor.swift
//  Task
//
//  Created by mohamed salah on 3/18/21.
//

import UIKit
import Alamofire

class GroupInfoInteractor: GroupInfoPresenterToGroupInfoInteractorProtocol  {
    var groupInfoInteractorToGroupInfoPresenterDelegate: GroupInfoInteractorToGroupInfoPresenterProtocol?
    var groupId: String?
    var topicId: String?
    var groupInfo: displayableGroupInfoModelProtocol?
    var topic: displayableTopicModelProtocol?
    var list = [GroupInfoProtocol]()
    var replies: [displayableReplyModelProtocol]?
    let serialGroup = DispatchGroup()
    
    func fetchGroupsInfoAPI() {
        serialGroup.enter()
        fetchGroupInfo()
        serialGroup.enter()
        fetchGroupTopic()
        serialGroup.notify(queue: DispatchQueue.main) {
            if let info = self.groupInfo {
                self.list.append(info)
            }
            if let topic = self.topic {
                self.list.append(topic)
            }
            if let replies = self.replies {
                self.list.append(contentsOf: replies)
            }
            
            self.groupInfoInteractorToGroupInfoPresenterDelegate?.groupInfoFetched(list: self.list)
        }
    }
    
    func fetchGroupInfo() {
        let parameter: [String: Any] =
            ["api_key": flickerApiKey,
             "method": flickerGroupInfoMethod,
             "format": "json",
             "group_id": groupId ?? "",
             "nojsoncallback": 1]
        
        AF.request(getFlickerBaseAPI,
                   method: .get,
                   parameters: parameter,
                   encoding:  URLEncoding.default,
                   headers: nil).responseDecodable(of:GroupInfoRoot<GroupInfoModel>.self) { [weak self] (response) in
                    switch  response.result {
                    case  .success(let root):
                        self?.groupInfo = root.groups
                        self?.serialGroup.leave()
                        break
                    case .failure(let error):
                        self?.serialGroup.leave()
                        break
                    }
                    
                   }
    }
    
    func fetchGroupTopic() {
        let parameter: [String: Any] =
            ["api_key": flickerApiKey,
             "method": flickerTopicsListMethod,
             "format": "json",
             "group_id": groupId ?? "",
             "page" : 0,
             "per_page": 1,
             "nojsoncallback": 1]
        
        AF.request(getFlickerBaseAPI,
                   method: .get,
                   parameters: parameter,
                   encoding:  URLEncoding.default,
                   headers: nil).responseDecodable(of:TopicRoot<TopicModelRoot<TopicModel>>.self) { [weak self]  (response) in
                    switch  response.result {
                    case  .success(let root):
                        if let topic =  root.topics.topic?.first {
                            self?.topic = topic
                            self?.topicId = topic.id
                            self?.fetchReplies()
                        } else {
                            self?.serialGroup.leave()
                        }
                        
                        break
                    case .failure(let error):
                        self?.serialGroup.leave()
                        break
                    }
                    
                   }
    }
    
    func fetchReplies() {
        let parameter: [String: Any] =
            ["api_key": flickerApiKey,
             "method": flickerGetRepliesMethod,
             "format": "json",
             "group_id": groupId ?? "",
             "topic_id": topicId ?? "",
             "page" : 0,
             "per_page": 20,
             "nojsoncallback": 1]
        
        AF.request(getFlickerBaseAPI,
                   method: .get,
                   parameters: parameter,
                   encoding:  URLEncoding.default,
                   headers: nil).responseDecodable(of:ReplyRoot<ReplyModelRoot<ReplyModel>>.self) { [weak self] (response) in
                    switch  response.result {
                    case  .success(let root):
                        if let replies =  root.replies.reply {
                            self?.replies = replies
                            self?.serialGroup.leave()
                        } else {
                            self?.serialGroup.leave()
                        }
                        break
                    case .failure(let error):
                        self?.serialGroup.leave()
                        break
                    }
                    
                   }
    }
    
}
