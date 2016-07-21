//
//  AssetsFinder.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/8/16.
//  Copyright © 2016 Ido Mizrachi. All rights reserved.
//

import Cocoa

class AssetsFinder {
    let assetsSuffix = ".xcassets"
    
    let fileManager : NSFileManager
    
    init(fileManager: NSFileManager) {
        self.fileManager = fileManager
    }

    func findAssets(inPath path : String) -> [String] {
        var assets : [String] = []
        let enumerator = fileManager.enumeratorAtPath(path)
        while let element = enumerator?.nextObject() as? String  {
            if isAsset(element) {
                assets.append(path + "/" + element)
            }
        }
        return assets
    }
    
    func isAsset(element : String) -> Bool {
        return element.hasSuffix(assetsSuffix)
    }
    
}
