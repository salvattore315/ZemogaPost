//
//  Extension.swift
//  ZemogaPost
//
//  Created by Salvador Martinez on 12/12/20.
//

import Foundation
import Alamofire


extension JSONDecoder {
    func decodeResponse<T:Decodable>(from response: Data?) -> T? {
        guard let responseData = response else {
           return nil
        }
        do {
            let item = try decode(T.self, from: responseData)
            return item
        } catch {
            print(error)
            return nil
        }
    }
}
