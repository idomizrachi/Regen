//
//  Usage.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/15/16.
//

import Foundation

class Usage {
    static func display(color: Bool) {
        let options = [ ["--version          ", "Prints the current version"],
                        ["--output FILE      ", "Set the generated file name (without extension)"] ,
                        ["--scanType TYPE    ", "Use images or localization\n\t\timages - scans the projects .xcassets files\n\t\tlocalization - scans the projects Localizable.strings file"],
                        ["--language LANGUAGE", "Use swift or objc\n\t\tSets the language of the generated filess"],
                        ["--verbose or -v    ", "Print detailed information while running"],
                        ["--nocolor          ", "Don't use colors in console output"]
        ]
        var usageHeader: String = "Usage:"
        if color {
            usageHeader = usageHeader.bold.underline
        }
        
        print(usageHeader)
        levelPrint("$ regen [options]")
        newLine()

        var optionsHeader: String = "Options"
        if color {
            optionsHeader = optionsHeader.bold.underline
        }
        print(optionsHeader)
        for (option) in options {
            levelPrint("\(option[0]) \t\t\t \(option[1])")
        }
    }
    
    private static func levelPrint(_ string : String) {
        print("\t" + string)
    }
    
    private static func newLine() {
        print("")
    }
    
}
