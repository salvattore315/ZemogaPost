//
//  PostPresenter.swift
//  ZemogaPost
//
//  Created by Salvador Martinez on 12/12/20.
//

import Foundation
import RealmSwift

class PostPresenter: Presenter {
    
    weak private var postView : ServiceTableView?
    
    //MARK: - Init Presenter
    override init() {
        super.init()
    }
    
    public func attachView(view: ServiceTableView) {
        postView = view
    }
    
    public func detachView() {
        postView = nil
    }
    
    //MARK: - Action
    public func setReadedInRealm(idPost: Int) {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "id == \(idPost)")
        let resultPost = realm.objects(Post.self).filter(predicate)
        let post = resultPost.first
        
        try! realm.write {
            post?.isRead = true
        }
    }

    //MARK: - UserDefault
    public func savePostInUserDefault(post: Post) {
        SessionManager.saveCodableInSession(codable: post.encode(),
                                            key: GlobalConstants.Keys.savePostSelected)
    }
    
    //MARK: - Service
    public func getPostsService() {
        self.postView?.startCallingService()
        service.callServiceObject(parameters: nil, service: GlobalConstants.nameServices.getPost) { [self] (data, error) in
            if error != nil {
                self.postView?.setError(error: "")
            }
            
            if data != nil {
                if let posts: [Post] = JSONDecoder().decodeResponse(from: data){
                    print(posts)
                    saveAllPostInRealm(posts: posts)
                    getAllPostInRealm()
                    self.postView?.finishCallService()
                } else {
                    self.postView?.setError(error: "")
                }
            }
        }
    }
    
    //MARK: - Realm
    //MARK: - Realm Save & Update
    public func isSavedPostsInRealm() -> Bool {
        let realm = try! Realm()
        let resultPost = realm.objects(Post.self)
        return resultPost.count > 0
    }
    
    public func saveAllPostInRealm(posts: [Post]) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(posts)
        }
    }
        
    //MARK: - Realm Get
    public func getPostInRealm(idPost: Int) -> Post? {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "id == \(idPost)")
        let resultPost = realm.objects(Post.self).filter(predicate)
        return resultPost.first
    }
        
    public func getAllPostInRealm() {
        let realm = try! Realm()
        let resultPost = realm.objects(Post.self)
        self.postView?.setArray(ObjectCodable: resultPost.map({$0}))
    }
    
    public func getFavoritePostsInRealm() {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "isFavorite == true")
        let resultPost = realm.objects(Post.self).filter(predicate)
        
        self.postView?.setArray(ObjectCodable: resultPost.map({$0}))
    }
    
    //MARK: - Realm delete
    public func deleteAllPostInRealm() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    public func deletePostInRealm(idPost: Int,
                                isAllSelected: Bool) {
        let post = getPostInRealm(idPost: idPost)
        let realm = try! Realm()
        try! realm.write {
            realm.delete(post!)
        }
        if(isAllSelected) {
            getAllPostInRealm()
        } else {
            getFavoritePostsInRealm()
        }
    }
}
