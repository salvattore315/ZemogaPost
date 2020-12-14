//
//  GlobalConstant.swift
//  ZemogaPost
//
//  Created by Salvador Martinez on 12/12/20.
//

import Foundation
import UIKit

import Foundation
import UIKit
var apiUrl = ""

//MARK: Loading Configuration Details
enum Environment: String {
    case development = "development"
    case production = "production"
    
    private struct Domains {
        static let development = "https://jsonplaceholder.typicode.com/"
        static let production = ""
    }
    
    private struct Routes {
        static let api = ""
    }
    
    var baseUrl: String {
        switch self {
        case .development:
            return setUrl(domain: Domains.development,
                          route: Routes.api)
        case .production:
            return setUrl(domain: Domains.production,
                          route: Routes.api)
        }
    }
}

func setUrl(domain:String, route:String) -> String {
    apiUrl = domain + route
    return apiUrl
}

struct Configuration {
    var environment: Environment = {
        if let configuration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String {
            return Environment.production
        }
        return Environment.development
    }()
}

struct GlobalConstants {
    
    //MARK: Configuring the environment
    private static let baseUrl = apiUrl
    
    //MARK: - Keys
    struct Keys{
        static let savePostSelected = "savePostSelected"
    }
    
    //MARK: ENDPOINTS
    struct Endpoints {
        static let post = baseUrl+"posts"
        
        static func getUser(userId: String) -> String {
            return baseUrl + "users?id=" + userId
        }
        
        static func getCommentsOfPost(postId: String) -> String {
            return baseUrl + "posts/" + postId + "/comments"
        }
    }
    
    //MARK: Headers
    struct Headers {
        static let contentType = "application/json"
    }
    
    //MARK: - API SERVICES
    struct nameServices {
        static let getPost = "post"
        static let getUser = "getUser"
        static let getCommentsOfPost = "getCommentsOfPost"
    }
    
}
