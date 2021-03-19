//
//  GoupListInteractor.swift
//  Task
//
//  Created by mohamed salah on 3/18/21.
//

import UIKit
import Alamofire

class GroupListInteractor: GroupListPresenterToGroupListInteractorProtocol  {
    var groupListInteractorToGroupListPresenterProtocol: GroupListInteractorToGroupListPresenterProtocol?
    var page = 0
    let pageSize = 10
    
    func fetchGroupsAPI() {
        let parameter: [String: Any] =
            ["api_key": flickerApiKey,
             "method": flickerGetGroupsMethod,
             "format": "json",
             "per_page": pageSize,
             "page": page,
             "text": "Cars",
             "nojsoncallback": 1]
        
        AF.request(getFlickerBaseAPI,
                   method: .get,
                   parameters: parameter,
                   encoding:  URLEncoding.default,
                   headers: nil).responseDecodable(of:GroupRoot<GroupRootModel<GroupModel>>.self) { (response) in
                    switch  response.result {
                    case  .success(let rootGroup):
                        self.groupListInteractorToGroupListPresenterProtocol?.groupsFetchedWithList(list: rootGroup.groups.groupList)
                        DataBaseHandler.saveGroupList(rootGroup.groups.groupList)
                        self.page += 1
                        break
                    case .failure(let error):
                        self.groupListInteractorToGroupListPresenterProtocol?.groupsFetchedWithList(list: DataBaseHandler.getGroupList())
                        self.groupListInteractorToGroupListPresenterProtocol?.error()
                        break
                    }
                    
                   }
    }
    
}
