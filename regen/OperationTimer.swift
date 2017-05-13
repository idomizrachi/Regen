//
//  OperationTimer.swift
//  regen
//
//  Created by Ido Mizrachi on 5/13/17.
//  Copyright © 2017 Ido Mizrachi. All rights reserved.
//

import Foundation

class OperationTimer {
    
    var startDate: Date? = nil
    
    func start() {
        self.startDate = Date()
    }
    
    func end() -> TimeInterval{
        guard let startDate = self.startDate else {
            return 0
        }
        let endDate = Date()
        return endDate.timeIntervalSince(startDate)
    }    
    
}
