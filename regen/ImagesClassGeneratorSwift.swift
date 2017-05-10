//
//  ImagesClassGeneratorSwift.swift
//  regen
//
//  Created by Ido Mizrachi on 5/10/17.
//

import Foundation

class ImagesClassGeneratorSwift: ImagesClassGenerator {
    func generateClass(fromImages images : [ImageAssetMetadata], generatedFile : String) {
        var file = ""
        
        file += "public struct \(generatedFile) {\n"        
        for metadata in images {
            file += "    static let \(metadata.property) = \"\(metadata.imageNamed)\"\n"
        }
        file += "}\n"

        do {
            try file.write(toFile: generatedFile + ".swift", atomically: false, encoding: String.Encoding.utf8)
        } catch let error {
            print("Error: \(error)")
        }
    }
}
