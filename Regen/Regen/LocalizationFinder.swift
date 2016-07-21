//
//  LocalizationFinder.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/15/16.
//  Copyright © 2016 Ido Mizrachi. All rights reserved.
//

import Foundation

class LocalizationFinder{
    
    let fileManager : NSFileManager
    
    init(fileManager: NSFileManager) {
        self.fileManager = fileManager
    }
    
    func findLocalizationFiles(inPath path : String) -> [String] {
        let enumerator = fileManager.enumeratorAtPath(path)
    
        
        var localizationFiles : [String] = []
        while let element = enumerator?.nextObject() as? String  {
            if element.hasSuffix(LocalizationOperation.localizableStrings) {
                localizationFiles.append(element)
            }
        }
        
        return localizationFiles
    }
    
}