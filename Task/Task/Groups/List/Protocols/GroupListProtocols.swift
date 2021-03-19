//
//  GroupListProtocols.swift
//  Task
//
//  Created by mohamed salah on 3/19/21.
//

import Foundation
import UIKit

protocol GroupListViewToGroupListPresenterProtocol: class {
    var groupListPresenterToGroupListViewDelegate: GroupListPresenterToGroupListViewProtocol? { get set }
    var groupListPresenterToRouterDelegate: GroupListPresenterToRouterProtocol? {get set}
    var groupListPresenterToGroupListInteractorDelegate: GroupListPresenterToGroupListInteractorProtocol? { get set }
    func fetchGroupList()
    func error()
    func navigateToInfoScreen(navigationConroller navigationController: UINavigationController, groupId: String)
}

protocol GroupListPresenterToGroupListInteractorProtocol: class {
    var groupListInteractorToGroupListPresenterProtocol: GroupListInteractorToGroupListPresenterProtocol? { get set }
    func fetchGroupsAPI()
}

protocol GroupListPresenterToRouterProtocol: class {
    static func createGroupModule(groupsViewController: GroupListViewController)
    func pushToInfoScreen(navigationConroller navigationController:UINavigationController, groupId: String)
}

protocol GroupListPresenterToGroupListViewProtocol: class {
    var groupListViewToGroupListPresenterProtocol: GroupListViewToGroupListPresenterProtocol?  { get set }
    func groupsFetchedWithList(list: [displayableGroupModelProtocol])
    func error()
}

protocol GroupListInteractorToGroupListPresenterProtocol: class {
    func groupsFetchedWithList(list: [displayableGroupModelProtocol])
    func error()
}
