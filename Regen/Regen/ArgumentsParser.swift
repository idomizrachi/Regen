//
//  ArgumentsParser.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/15/16.
//  Copyright © 2016 Ido Mizrachi. All rights reserved.
//

import Foundation

class ArgumentsParser {
    
    let arguments : [String]
    
    init(arguments : [String]) {
        self.arguments = arguments
    }
    
    func operationType() -> OperationType {
        if isVersionOperationType() {
            return .Version
        }
        
        return .Usage
    }
    
    func isVersionOperationType() -> Bool {
        return true
    }
    
}


