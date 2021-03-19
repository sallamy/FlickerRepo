//
//  GroupsRouter.swift
//  Task
//
//  Created by mohamed salah on 3/18/21.
//

import UIKit

class GroupsRouter: GroupListPresenterToRouterProtocol {
    static func createGroupModule(groupsViewController: GroupListViewController) {
        let presenter = GroupListPreseneter()
        let interactor = GroupListInteractor()
        let router = GroupsRouter()
        presenter.groupListPresenterToRouterDelegate = router
        presenter.groupListPresenterToGroupListInteractorDelegate = interactor
        presenter.groupListPresenterToGroupListViewDelegate = groupsViewController
        interactor.groupListInteractorToGroupListPresenterProtocol = presenter
        groupsViewController.groupListViewToGroupListPresenterProtocol = presenter
    }
    
    static func createGroupInfoModule(groupId: String) -> GroupInfoViewController {
        
        let viewController = mainstoryboard.instantiateViewController(withIdentifier: "GroupInfoViewController") as! GroupInfoViewController
        
        let presenter = GroupInfoPreseneter()
        let interactor = GroupInfoInteractor()
        interactor.groupId = groupId
        let router = GroupsRouter()
        presenter.groupInfoPresenterToRouterDelegate = router
        presenter.groupInfoPresenterToGroupInfoInteractorDelegate = interactor
        presenter.groupInfoPresenterToGroupInfoViewDelegate = viewController
        interactor.groupInfoInteractorToGroupInfoPresenterDelegate = presenter
        viewController.groupInfoViewToGroupInfoPresenterDelegate = presenter
        
        return viewController
        
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func pushToInfoScreen(navigationConroller navigationController:UINavigationController, groupId: String) {
        let groupInfoViewController = GroupsRouter.createGroupInfoModule(groupId: groupId)
        navigationController.pushViewController(groupInfoViewController,animated: true)
    }
}
