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
    
    let fileManager : FileManager
    
    init(fileManager : FileManager) {
        self.fileManager = fileManager
    }
    
    func run(_ searchPath : String, output : String) {
        let localizationFinder = LocalizationFinder(fileManager: fileManager)
        let files = localizationFinder.findLocalizationFiles(inPath: searchPath)
        let parser = LocalizationParser()        
        var localizationEntries : [LocalizationEntry] = []
        for file in files {            
            let parsedFile = parser.parseLocalizationFile(file)
            parser.appendEntries(parsedFile, to: &localizationEntries)
        }
        let generator = LocalizationClassGenerator()
        generator.generateClass(fromLocalizationEntries: localizationEntries, generatedFile: output)
    }
}
