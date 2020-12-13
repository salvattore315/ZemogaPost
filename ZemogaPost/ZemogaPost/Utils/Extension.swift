//
//  Extension.swift
//  ZemogaPost
//
//  Created by Salvador Martinez on 12/12/20.
//
import Foundation
import Alamofire
import RealmSwift


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

extension Decodable {
    static func decode(data:Data?) -> Self?{
        let decoder = JSONDecoder()
        if data == nil {
            return nil
        }
        return try? decoder.decode(Self.self, from: data!)
    }
}

extension Encodable {
    func encode(with encoder: JSONEncoder = JSONEncoder()) -> Data? {
        return try? encoder.encode(self)
    }
}
