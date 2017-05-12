//
//  LocalizationClassGeneratorSwift.swift
//  Regen
//
//  Created by Ido Mizrachi on 5/10/16.
//

import Foundation

class LocalizationClassGeneratorSwift: LocalizationClassGenerator {
    func generateClass(fromLocalizationEntries localization : [LocalizationEntry], generatedFile : String) {
        var file = ""
        
        file += "public struct \(generatedFile) {\n"
        for localizationEntry in localization {
            file += "    static let \(localizationEntry.property) = NSLocalizedString(\"\(localizationEntry.key)\", comment: \"\")\n"
        }
        file += "}\n"
        
        do {
            try file.write(toFile: generatedFile + ".swift", atomically: false, encoding: String.Encoding.utf8)
        } catch let error {
            Logger.error("\(error)")
        }
    }
}
