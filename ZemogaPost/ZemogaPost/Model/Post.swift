//
//  Post.swift
//  ZemogaPost
//
//  Created by Salvador Martinez on 12/12/20.
//

import Foundation
import RealmSwift

class Post: Object, Codable {
    var id = RealmOptional<Int>()
    @objc dynamic var title: String?
    @objc dynamic var body: String?
    var userId = RealmOptional<Int>()
//    @objc dynamic var isFavorite: Bool = false
 //   var isRead = RealmOptional<Bool>(false)
}
