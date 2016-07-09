//
//  ResourceesClassGenerator.swift
//  SafeAsset
//
//  Created by Ido Mizrachi on 7/8/16.
//  Copyright © 2016 Ido Mizrachi. All rights reserved.
//

import Cocoa

class ResourceesClassGenerator {
    
    func generateClass(fromImages images : [ImageAssetMetadata], generatedFile : String) {
        var headerFile = ""
        var implementationFile = ""
        
        headerFile += "@import Foundation;\n\n"
        headerFile += "extern const struct \(generatedFile) {\n"
        
        implementationFile += "#import \"\(generatedFile).h\"\n"
        implementationFile += "const struct \(generatedFile) \(generatedFile) = {\n"
        
        for metadata in images {
            headerFile += "    __unsafe_unretained NSString *\(metadata.property);\n"
            implementationFile += "    .\(metadata.property) = @\"\(metadata.imageNamed)\",\n"

        }
                
        headerFile += "\n} \(generatedFile);\n"
        implementationFile += "\n};\n"
        
        do {
            try headerFile.writeToFile(generatedFile + ".h", atomically: false, encoding: NSUTF8StringEncoding)
            try implementationFile.writeToFile(generatedFile + ".m", atomically: false, encoding: NSUTF8StringEncoding)
        } catch let error {
            print("Error: \(error)")
        }
    }
}
