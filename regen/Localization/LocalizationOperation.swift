//
//  LocalizationOperation.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/15/16.
//

import Foundation

class LocalizationOperation{
    
    static let localizableStrings = "Localizable.strings"
    
    let fileManager : FileManager
    let language: Language
    
    init(fileManager : FileManager, language: Language) {
        self.fileManager = fileManager
        self.language = language
    }
    
    func run(_ searchPath : String, output : String) {
        Logger.info("Localization scan: started")
        let localizationFinder = LocalizationFinder(fileManager: fileManager)
        let files = localizationFinder.findLocalizationFiles(inPath: searchPath)
        let parser = LocalizationParser()        
        var localizationEntries : [LocalizationEntry] = []
        Logger.debug("\tParse localization files: started")
        for file in files {
            //Scanning only the english file saves a few seconds
            if file.hasSuffix("en.lproj/Localizable.strings") {
                let parsedFile = parser.parseLocalizationFile(file)
                parser.appendEntries(parsedFile, to: &localizationEntries)
            }
        }
        //TODO: Add validator for duplicated properties
        Logger.debug("\tParse localization files: finished (\(localizationEntries.count) keys found)")
        let generator: LocalizationClassGenerator
        if language == .ObjC {
            generator = LocalizationClassGeneratorObjC()
        } else {
            generator = LocalizationClassGeneratorSwift()
        }
        generator.generateClass(fromLocalizationEntries: localizationEntries, generatedFile: output)
        Logger.info("Localization scan: finished")
    }
}
