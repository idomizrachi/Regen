//
//  LocalizationClassGenerator.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/16/16.
//  Copyright © 2016 Ido Mizrachi. All rights reserved.
//

import Foundation

class LocalizationClassGenerator {
    func generateClass(fromLocalizationEntries localization : [LocalizationEntry], generatedFile : String) {
        var headerFile = ""
        var implementationFile = ""
        
        headerFile += "@import Foundation;\n\n"
        headerFile += "@interface \(generatedFile) : NSObject\n\n"
        
        implementationFile += "#import \"\(generatedFile).h\"\n\n"
        implementationFile += "@implementation \(generatedFile)\n\n"
        
        for localizationEntry in localization {
            headerFile += "+(NSString *) \(localizationEntry.property);\n"
            implementationFile += "+(NSString *) \(localizationEntry.property) {\n"
            implementationFile += "    return NSLocalizedString(@\"\(localizationEntry.key)\" , \"\");\n"
            implementationFile += "}\n\n";
        }
        
        headerFile += "@end"
        implementationFile += "@end"
        
        do {
            try headerFile.writeToFile(generatedFile + ".h", atomically: false, encoding: NSUTF8StringEncoding)
            try implementationFile.writeToFile(generatedFile + ".m", atomically: false, encoding: NSUTF8StringEncoding)
        } catch let error {
            print("Error: \(error)")
        }
    }
}