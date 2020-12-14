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
        configuration.circleStrokeForegroundColor = UIColor.white//GlobalConstants.Colors.fontColor
        configuration.successColor = UIColor.white//GlobalConstants.Colors.fontColor
        configuration.errorColor = UIColor.white//GlobalConstants.Colors.fontColor
        configuration.isFullScreen = true
        configuration.statusColor = UIColor.white//GlobalConstants.Colors.fontColor
        configuration.backgroundFillColor = .systemBlue
        configuration.backgroundType = .solid
        configuration.minimumDisplayTime = 3.0
        configuration.minimumSuccessDisplayTime = 3.0
        configuration.minimumErrorDisplayTime = 3.0
        KVNProgress.setConfiguration(configuration)
        
    }
    
}
