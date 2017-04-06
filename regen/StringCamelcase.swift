//
//  StringCamelcase.swift
//  regen
//
//  Created by Ido Mizrachi on 4/6/17.
//  Copyright © 2017 Ido Mizrachi. All rights reserved.
//

import Foundation

extension String {
    func camelcase() -> String {
        var components: [String] = []
        let spaceComponents = self.components(separatedBy: " ")
        
        for spaceComponent in spaceComponents {
            let dashComponents = spaceComponent.components(separatedBy: "-")
            for dashComponent in dashComponents {
                components.append(dashComponent)
            }
        }
        var camelcase = ""
        for index in 0..<components.count {
            let component = components[index]
            if index == 0 {
                camelcase += component.lowercased()
            } else {
                camelcase += component.capitalized
            }
        }
        return camelcase
    }
}
