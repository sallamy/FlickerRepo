//
//  GroupInfoProtocols.swift
//  Task
//
//  Created by mohamed salah on 3/19/21.
//

import Foundation

protocol GroupInfoViewToGroupInfoPresenterProtocol: class {
    var groupInfoPresenterToGroupInfoViewDelegate: GroupInfoPresenterToGroupInfoViewProtocol? { get set }
    var groupInfoPresenterToRouterDelegate: GroupsRouter? {get set}
    var groupInfoPresenterToGroupInfoInteractorDelegate: GroupInfoPresenterToGroupInfoInteractorProtocol? { get set }
    func fetchGroupInfo()
    func error()
}

protocol GroupInfoPresenterToGroupInfoInteractorProtocol: class {
    var groupInfoInteractorToGroupInfoPresenterDelegate: GroupInfoInteractorToGroupInfoPresenterProtocol? { get set }
    func fetchGroupsInfoAPI()
}

protocol GroupInfoPresenterToGroupInfoViewProtocol: class {
    var groupInfoViewToGroupInfoPresenterDelegate: GroupInfoViewToGroupInfoPresenterProtocol?  { get set }
    func groupInfoFetched(list: [GroupInfoProtocol])
    func error()
}

protocol GroupInfoInteractorToGroupInfoPresenterProtocol: class {
    func groupInfoFetched(list: [GroupInfoProtocol])
    func error()
}
