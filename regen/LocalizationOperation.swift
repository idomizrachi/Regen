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
        let localizationFinder = LocalizationFinder(fileManager: fileManager)
        let files = localizationFinder.findLocalizationFiles(inPath: searchPath)
        let parser = LocalizationParser()        
        var localizationEntries : [LocalizationEntry] = []
        for file in files {            
            let parsedFile = parser.parseLocalizationFile(file)
            parser.appendEntries(parsedFile, to: &localizationEntries)
        }
        let generator: LocalizationClassGenerator
        if language == .ObjC {
            generator = LocalizationClassGeneratorObjC()
        } else {
            generator = LocalizationClassGeneratorSwift()
        }
        generator.generateClass(fromLocalizationEntries: localizationEntries, generatedFile: output)
    }
}
