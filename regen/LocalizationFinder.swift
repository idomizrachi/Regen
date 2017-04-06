//
//  LocalizationFinder.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/15/16.
//  Copyright © 2016 Ido Mizrachi. All rights reserved.
//

import Foundation

class LocalizationFinder{
    
    let fileManager : FileManager
    
    init(fileManager: FileManager) {
        self.fileManager = fileManager
    }
    
    func findLocalizationFiles(inPath path : String) -> [String] {
        let enumerator = fileManager.enumerator(atPath: path)
        var localizationFiles : [String] = []
        while let element = enumerator?.nextObject() as? String  {
            if element.hasSuffix(LocalizationOperation.localizableStrings) {
                localizationFiles.append(path + "/" + element)
            }
        }        
        return localizationFiles
    }
    
}
