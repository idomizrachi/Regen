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
        headerFile += "@interface \(generatedFile) : NSObject \n\n"
        
        implementationFile += "#import \"\(generatedFile).h\"\n"
        implementationFile += "@implementation \(generatedFile)\n"
        
        for metadata in images {
            headerFile += "+(NSString *)\(metadata.property);\n"
            implementationFile += "+(NSString *)\(metadata.property) {\n"
            implementationFile += "    return @\"\(metadata.imageNamed)\";\n"
            implementationFile += "}\n"
        }
                
        headerFile += "@end\n"

        implementationFile += "@end\n"
        
        do {
            try headerFile.writeToFile(generatedFile + ".h", atomically: false, encoding: NSUTF8StringEncoding)
            try implementationFile.writeToFile(generatedFile + ".m", atomically: false, encoding: NSUTF8StringEncoding)
        } catch let error {
            print("Error: \(error)")
        }
    }
}
