//
//  GroupListPreseneter.swift
//  Task
//
//  Created by mohamed salah on 3/18/21.
//

import UIKit

class GroupInfoPreseneter: GroupInfoViewToGroupInfoPresenterProtocol,
                           GroupInfoInteractorToGroupInfoPresenterProtocol  {
    
    var groupInfoPresenterToGroupInfoViewDelegate: GroupInfoPresenterToGroupInfoViewProtocol?
    var groupInfoPresenterToRouterDelegate: GroupsRouter?
    var groupInfoPresenterToGroupInfoInteractorDelegate: GroupInfoPresenterToGroupInfoInteractorProtocol?
    
    func fetchGroupInfo() {
        self.groupInfoPresenterToGroupInfoInteractorDelegate?.fetchGroupsInfoAPI()
    }
    
    func groupInfoFetched(list: [GroupInfoProtocol]) {
        self.groupInfoPresenterToGroupInfoViewDelegate?.groupInfoFetched(list: list)
    }
    
    func error() {
        
    }
    
}
