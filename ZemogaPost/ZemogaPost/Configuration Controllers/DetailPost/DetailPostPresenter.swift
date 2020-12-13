//
//  DetailPostPresenter.swift
//  ZemogaPost
//
//  Created by Salvador Martinez on 12/12/20.
//

import Foundation
import Foundation

protocol ServiceDetailPostView: ServiceTableView {
    func setUser(user: User)
    func setComments(comments: [Comment])
    func setDescription(description: String)
}

class DetailPostPresenter: Presenter {
    
    weak private var detailPostView : ServiceDetailPostView?
    
    override init() {
        super.init()
    }
    
    public func attachView(view: ServiceDetailPostView) {
        detailPostView = view
    }
    
    public func detachView() {
        detailPostView = nil
    }
    
    public func getDescription() {
        if let post: Post = SessionManager.getCodableSession(key: GlobalConstants.Keys.savePostSelected) {
            self.detailPostView?.setDescription(description: post.body ?? "")
        }
    }
    
    public func getService() {
        getUser()
    }
    
    public func getUser() {
        self.detailPostView?.startCallingService()
        service.callServiceObject(parameters: nil, service: GlobalConstants.nameServices.getUser) { [self] (data, error) in
            if error != nil {
                
            }
            
            if data != nil {
                if let users: [User] = JSONDecoder().decodeResponse(from: data){
                    print(users)
                    if(!users.isEmpty){
                        self.detailPostView?.setUser(user: users[0])
                        getComments()
                    } else {
                        
                    }
                }
            }
        }
    }
    
    public func getComments() {
        service.callServiceObject(parameters: nil, service: GlobalConstants.nameServices.getCommentsOfPost) { [self] (data, error) in
            if error != nil {
                
            }
            
            if data != nil {
                if let comments: [Comment] = JSONDecoder().decodeResponse(from: data){
                    print(comments)
                    self.detailPostView?.setComments(comments: comments)
                    
                } else {
                    
                }
                self.detailPostView?.finishCallService()
            }
        }
    }
}
