//
//  PostPresenter.swift
//  ZemogaPost
//
//  Created by Salvador Martinez on 12/12/20.
//

import Foundation

class PostPresenter: Presenter {
    
    weak private var postView : ServiceTableView?
    
    override init() {
        
    }
    
    func attachView(view: ServiceTableView) {
        postView = view
    }
    
    func detachView() {
        postView = nil
    }
    
    
    func getPost() {
        self.postView?.startCallingService()
        service.callServiceObject(parameters: nil, service: GlobalConstants.nameServices.getPost) { [self] (data, error) in
            if error != nil {
                
            }
            
            if data != nil {
                if let posts: [Post] = JSONDecoder().decodeResponse(from: data){
                    print(posts)
                    self.postView?.setArray(ObjectCodable: posts)
                    self.postView?.finishCallService()
                }
            }
        }
    }
}
