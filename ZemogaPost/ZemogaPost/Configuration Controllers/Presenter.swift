//
//  Presenter.swift
//  ZemogaPost
//
//  Created by Salvador Martinez on 12/12/20.
//

import Foundation

protocol ServiceTableView: NSObjectProtocol {
    func startCallingService()
    func finishCallService()
    func setArray(ObjectCodable: Array<Any>)
    func setEmpty()
    func setError(error: String?)
    func startDelete()
    func finishDelete()
}

class Presenter {
    public let service: ShellWebService = ShellWebService()
    public let configuration = Configuration()
    var baseUrl = "", environment = ""
        
    init() {
        environment = configuration.environment.rawValue
        baseUrl = configuration.environment.baseUrl
    }
    
}
