//
//  Usage.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/15/16.
//

import Foundation


// Usage:
// regen supports two type of code generation:
// 1. Images - by scanning ".xcassets" packages
// 2. Localization - by scanning string files
//
// Type any of the following for additiona help:
// regen images --help
// regen localization --help

class Usage {

    static func display() {
        let usage = #"""
        Usage:
            $ regen localization [options]
            or
            $ regen images [options]


        Localization Parameters:
            --search-path           Set the path of the .strings files, for example: /Users/me/dev/project
            --template              Set the Stencil template file, for example: Template.txt
            --output-filename       Set the output filename, for example: Localization.swift
            --output-class-name     Set the generated class name, for example: LocalizableStrings
            --base-language-code    Set the locate of the .strings file that will be scanned

        Images Parameters:
            --template      Set the Stencil template file
            --output         Set the output file
        """#
        print(usage)
    }
}
