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
    
    public func getDescription() {
        if let post: Post = SessionManager.getCodableSession(key: GlobalConstants.Keys.savePostSelected) {
            self.detailPostView?.setDescription(description: post.body ?? "")
        }
    }
    
    //MARK: - Service
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
    
    //MARK: - Favorite
    public func setReadPost() {
        if let post: Post = SessionManager.getCodableSession(key: GlobalConstants.Keys.savePostSelected) {
            let postReal = getPostRealm(idPost: post.id.value!)
           // postReal?.internalInformation.isFavorite.value = !(postReal?.internalInformation.isFavorite.value! ?? false)
            savePost(post: postReal!)
        }
    }
    
    public func isPostFavorite(idPost: Int) -> Bool {
        let post = getPostRealm(idPost: idPost)
        //return post?.internalInformation?.isFavorite.value
        return false
    }
    
    //MARK: - Realm
    public func getPostRealm(idPost: Int) -> Post? {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "id == \(idPost)")
        let resultPost = realm.objects(Post.self).filter(predicate)
        return resultPost.first
    }
    
    public func savePost(post: Post) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(post, update: .modified)
        }
    }
}
