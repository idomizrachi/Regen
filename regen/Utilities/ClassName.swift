//
//  ClassName.swift
//  regen
//
//  Created by Ido Mizrachi on 10/3/17.
//  Copyright © 2017 Ido Mizrachi. All rights reserved.
//

import Cocoa

extension String {
    func className() -> String {
        return prefix(1).uppercased() + String(dropFirst())
    }
}
