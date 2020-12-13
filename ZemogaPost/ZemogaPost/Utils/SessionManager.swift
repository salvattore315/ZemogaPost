//
//  SessionManager.swift
//  ZemogaPost
//
//  Created by Salvador Martinez on 13/12/20.
//

import Foundation

class SessionManager {
    
    // MARK: Session Methods
    static func sessionConstains(key : String) -> Bool {
        
        let userDefaults : UserDefaults = UserDefaults.standard
        
        let value = userDefaults.value(forKey: key)
        if (value != nil) {
            return true
        } else {
            return false
        }
    }

    static func removeSession(key: String){
        
        let userDefault: UserDefaults = UserDefaults.standard
        userDefault.removeObject(forKey: key)
        userDefault.synchronize()
    }
    
    static func saveAnyObjectInSession(object : AnyObject?, key : String) {
        
        let userDefaults : UserDefaults = UserDefaults.standard
        userDefaults.set(object, forKey: key)
        userDefaults.synchronize()
    }
    
    static func saveCodableInSession(codable: Data?, key:String){
        if codable != nil{
            let userDefaults : UserDefaults = UserDefaults.standard
            userDefaults.set(codable, forKey: key)
            userDefaults.synchronize()
        }else{
            print("error saving")
        }
    }
    
    static func getCodableSession<T:Decodable>(key:String) -> T?{
        let userDefault: UserDefaults = UserDefaults.standard
        if let data = userDefault.data(forKey: key){
            return  T.decode(data: data)
        }
        return nil
    }
    
}
