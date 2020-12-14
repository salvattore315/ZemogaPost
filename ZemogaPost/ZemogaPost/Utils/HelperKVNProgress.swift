//
//  HelperKVNProgress.swift
//  ZemogaPost
//
//  Created by Salvador Martinez on 13/12/20.
//

import Foundation
import KVNProgress

class HelperKVNProgress {
    
    static func initScreenProgress(){
        
        let configuration = KVNProgressConfiguration.init()
        configuration.circleStrokeBackgroundColor = UIColor.white.withAlphaComponent(0.3)
        configuration.circleStrokeForegroundColor = .systemGreen
        configuration.successColor = .systemGreen
        configuration.errorColor = .systemGreen
        configuration.isFullScreen = true
        configuration.statusColor = .systemGreen
        configuration.backgroundFillColor = .white
        configuration.backgroundType = .solid
        configuration.minimumDisplayTime = 1.0
        configuration.minimumSuccessDisplayTime = 1.0
        configuration.minimumErrorDisplayTime = 1.0
        KVNProgress.setConfiguration(configuration)
        
    }
    
}
