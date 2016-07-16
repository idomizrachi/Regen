//
//  LocalizationOperation.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/15/16.
//  Copyright © 2016 Ido Mizrachi. All rights reserved.
//

import Foundation

class LocalizationOperation{
    
    static let localizableStrings = "Localizable.strings"
    
    
    func run(output : String = "Localization") {
        print("Localization operation")
        let fileManager = NSFileManager.defaultManager()
        
        let localizationFinder = LocalizationFinder(fileManager: fileManager)
        let files = localizationFinder.findLocalizationFiles(inPath: fileManager.currentDirectoryPath)
        let parser = LocalizationParser(fileManager: fileManager)        
        var localizationEntries : [LocalizationEntry] = []
        for file in files {            
            let newEntries = parser.parseLocalizationFile(file)
            parser.appendEntries(newEntries, to: &localizationEntries)
        }
        let generator = LocalizationClassGenerator()
        generator.generateClass(fromLocalizationEntries: localizationEntries, generatedFile: output)
    }
}