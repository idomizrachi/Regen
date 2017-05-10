//
//  ImagesClassGeneratorObjC.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/8/16.
//

import Cocoa

class ImagesClassGeneratorObjC: ImagesClassGenerator {
    func generateClass(fromImages images : [ImageAssetMetadata], generatedFile : String) {
        var headerFile = ""
        var implementationFile = ""
 
        headerFile += "@import Foundation;\n\n"
        headerFile += "@interface \(generatedFile) : NSObject\n\n"
        
        implementationFile += "#import \"\(generatedFile).h\"\n"
        implementationFile += "@implementation \(generatedFile)\n\n"
        
        
        for metadata in images {
            headerFile += "+(NSString *) \(metadata.property);\n"
            implementationFile += "+(NSString *) \(metadata.property) {\n"
            implementationFile += "    return \"\(metadata.imageNamed)\";\n"
            implementationFile += "}\n\n";
        }
        
        headerFile += "@end"
        implementationFile += "@end"
        
        do {
            try headerFile.write(toFile: generatedFile + ".h", atomically: false, encoding: String.Encoding.utf8)
            try implementationFile.write(toFile: generatedFile + ".m", atomically: false, encoding: String.Encoding.utf8)
        } catch let error {
            print("Error: \(error)")
        }
    }
}
