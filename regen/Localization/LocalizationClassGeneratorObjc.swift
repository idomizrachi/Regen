//
//  LocalizationClassGeneratorObjC.swift
//  Regen
//
//  Created by Ido Mizrachi on 5/10/16.
//

import Foundation

class LocalizationClassGeneratorObjC: LocalizationClassGenerator {
    func generateClass(fromLocalizationEntries localization : [LocalizationEntry], generatedFile : String) {
        var headerFile = ""
        var implementationFile = ""
        let className = String(NSString(string: generatedFile).lastPathComponent)
        
        headerFile += "@import Foundation;\n\n"
        headerFile += "@interface \(className) : NSObject\n\n"
        
        implementationFile += "#import \"\(className).h\"\n\n"
        implementationFile += "@implementation \(className)\n\n"
        
        for localizationEntry in localization {
            headerFile += "+(NSString *)\(localizationEntry.property);\n"
            implementationFile += "+(NSString *)\(localizationEntry.property) {\n"
            implementationFile += "    return NSLocalizedString(@\"\(localizationEntry.key)\" , \"\(localizationEntry.value)\");\n"
            implementationFile += "}\n\n";
        }
        
        headerFile += "@end"
        implementationFile += "@end"
                
        do {
            
            try headerFile.write(toFile: generatedFile + ".h", atomically: false, encoding: String.Encoding.utf8)
            try implementationFile.write(toFile: generatedFile + ".m", atomically: false, encoding: String.Encoding.utf8)
        } catch let error {
            Logger.error("\(error)")
        }
    }
}
