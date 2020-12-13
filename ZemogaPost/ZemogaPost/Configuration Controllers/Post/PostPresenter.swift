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
    
    public func isSavedPosts() -> Bool {
        let realm = try! Realm()
        let resultPost = realm.objects(Post.self)
        return resultPost.count > 0
    }
    
    //MARK: - UserDefault
    public func savePostSelected(post: Post) {
        SessionManager.saveCodableInSession(codable: post.encode(),
                                            key: GlobalConstants.Keys.savePostSelected)
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
                    let realm = try! Realm()
                    try! realm.write {
                        realm.add(posts)
                    }
                    getAllPost()
                    self.postView?.finishCallService()
                }
            }
        }
    }
    
    //MARK: - Realm
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
