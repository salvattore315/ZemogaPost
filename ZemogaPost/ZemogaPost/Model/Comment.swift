//
//  Comment.swift
//  ZemogaPost
//
//  Created by Salvador Martinez on 13/12/20.
//

import Foundation

struct Comment: Codable {
    var postId: Int?
    var id: Int?
    var name: String?
    var email: String?
    var body: String?
}
