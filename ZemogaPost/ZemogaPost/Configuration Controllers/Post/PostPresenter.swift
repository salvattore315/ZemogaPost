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
    

    //MARK: - UserDefault
    public func savePostSelected(post: Post) {
        SessionManager.saveCodableInSession(codable: post.encode(),
                                            key: GlobalConstants.Keys.savePostSelected)
    }
    
    public func isReaded(idPost: Int) {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "id == \(idPost)")
        let resultPost = realm.objects(Post.self).filter(predicate)
        let post = resultPost.first
        
        post?.internalInformation?.isRead = true
        
        try! realm.write {
            post?.internalInformation?.isRead = true
            post?.title = "que pasadoo salvador"
            realm.add(post!, update: .all)
        }
        
        let put = getPostRealm(idPost: idPost)
        print("ighi")
    }
    
    //MARK: - Service
    public func getPostsService() {
        self.postView?.startCallingService()
        service.callServiceObject(parameters: nil, service: GlobalConstants.nameServices.getPost) { [self] (data, error) in
            if error != nil {
                
            }
            
            if data != nil {
                if let posts: [Post] = JSONDecoder().decodeResponse(from: data){
                    print(posts)
                    saveAllPost(posts: posts)
                    getAllPost()
                    self.postView?.finishCallService()
                }
            }
        }
    }
    
    //MARK: - Realm
    public func isSavedPosts() -> Bool {
        let realm = try! Realm()
        let resultPost = realm.objects(Post.self)
        return resultPost.count > 0
    }
    
    public func saveAllPost(posts: [Post]) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(posts)
        }
    }
    
    public func savePost(post: Post) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(post, update: .all)
        }
    }
    
    public func setPostReaded(post: Post) {
        let realm = try! Realm()
            try! realm.write {
                post.internalInformation?.isRead = true
        }
    }
    
    public func getAllPost() {
        let realm = try! Realm()
        let resultPost = realm.objects(Post.self)
        
        self.postView?.setArray(ObjectCodable: resultPost.map({$0}))
    }
    
    public func getFavoritePost() {
        let realm = try! Realm()
        let resultPost = realm.objects(Post.self)
        
        self.postView?.setArray(ObjectCodable: resultPost.map({$0}))
    }
    
    public func getPostRealm(idPost: Int) -> Post? {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "id == \(idPost)")
        let resultPost = realm.objects(Post.self).filter(predicate)
        return resultPost.first
    }
    
    public func deleteAllPost() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    public func deletePost(post: Post) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(post)
        }
    }
}
