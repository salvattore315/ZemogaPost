//
//  Post.swift
//  ZemogaPost
//
//  Created by Salvador Martinez on 12/12/20.
//

import Foundation

struct Post: Codable {
    
    var id: Int?
    var title: String?
    var body: String?
    var userId: Int?
    var isFavorite: Bool = false
    var isRead: Bool = false
}
