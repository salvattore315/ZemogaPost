//
//  DetailPostPresenter.swift
//  ZemogaPost
//
//  Created by Salvador Martinez on 12/12/20.
//

import Foundation
import RealmSwift

protocol ServiceDetailPostView: ServiceTableView {
    func setUser(user: User)
    func setComments(comments: [Comment])
    func setDescription(description: String)
    func changeFavoriteButton(isFavorite: Bool)
}

class DetailPostPresenter: Presenter {
    
    weak private var detailPostView : ServiceDetailPostView?
    
    //MARK: - Init Presenter
    override init() {
        super.init()
    }
    
    public func attachView(view: ServiceDetailPostView) {
        detailPostView = view
    }
    
    public func detachView() {
        detailPostView = nil
    }
    
    //MARK: - Actions
    public func getDescription() {
        if let post: Post = SessionManager.getCodableSession(key: GlobalConstants.Keys.savePostSelected) {
            self.detailPostView?.setDescription(description: post.body ?? "")
        }
    }
    
    public func setFavoritePostInRealm(idPost: Int) {
            let realm = try! Realm()
            let predicate = NSPredicate(format: "id == \(idPost)")
            let resultPost = realm.objects(Post.self).filter(predicate)
            let post = resultPost.first
            try! realm.write {
                post?.isFavorite = !(post?.isFavorite ?? false)
            }
        self.detailPostView?.changeFavoriteButton(isFavorite: post?.isFavorite ?? false)
    }
    
    //MARK: - Service
    public func getService() {
        getUserService()
    }
    
    public func getUserService() {
        self.detailPostView?.startCallingService()
        service.callServiceObject(parameters: nil, service: GlobalConstants.nameServices.getUser) { [self] (data, error) in
            if error != nil {
                
            }
            
            if data != nil {
                if let users: [User] = JSONDecoder().decodeResponse(from: data){
                    print(users)
                    if(!users.isEmpty){
                        self.detailPostView?.setUser(user: users[0])
                        getCommentsService()
                    } else {
                        
                    }
                }
            }
        }
    }
    
    public func getCommentsService() {
        service.callServiceObject(parameters: nil, service: GlobalConstants.nameServices.getCommentsOfPost) { [self] (data, error) in
            if error != nil {
                self.detailPostView?.setError(error: "")
            }
            
            if data != nil {
                if let comments: [Comment] = JSONDecoder().decodeResponse(from: data){
                    print(comments)
                    self.detailPostView?.setComments(comments: comments)
                    self.detailPostView?.finishCallService()
                } else {
                    self.detailPostView?.setError(error: "")
                }
            }
        }
    }
    
    //MARK: - Realm
    public func getPostInRealm(idPost: Int) -> Post? {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "id == \(idPost)")
        let resultPost = realm.objects(Post.self).filter(predicate)
        return resultPost.first
    }

}
