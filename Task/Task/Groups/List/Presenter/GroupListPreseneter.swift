//
//  GroupListPreseneter.swift
//  Task
//
//  Created by mohamed salah on 3/18/21.
//

import UIKit

class GroupListPreseneter: GroupListViewToGroupListPresenterProtocol,GroupListInteractorToGroupListPresenterProtocol  {
 
    
    var groupListPresenterToGroupListViewDelegate: GroupListPresenterToGroupListViewProtocol?
    var groupListPresenterToRouterDelegate: GroupListPresenterToRouterProtocol?
    var groupListPresenterToGroupListInteractorDelegate: GroupListPresenterToGroupListInteractorProtocol?
    
    func fetchGroupList() {
        self.groupListPresenterToGroupListInteractorDelegate?.fetchGroupsAPI()
    }
    
    func error() {
        self.groupListPresenterToGroupListViewDelegate?.error()
    }
    
    func groupsFetchedWithList(list: [displayableGroupModelProtocol]) {
        self.groupListPresenterToGroupListViewDelegate?.groupsFetchedWithList(list: list)
    }
    
    func navigateToInfoScreen(navigationConroller navigationController: UINavigationController, groupId: String) {
        self.groupListPresenterToRouterDelegate?.pushToInfoScreen(navigationConroller: navigationController, groupId: groupId)
    }
}
