//
//  AssetsFinder.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/8/16.
//

import Cocoa

class AssetsFinder {
    public static let assetsSuffix = ".xcassets"
    
    let fileManager : FileManager
    
    init(fileManager: FileManager) {
        self.fileManager = fileManager
    }

    func findAssetsFiles(in path : String) -> [String] {
        var assets : [String] = []
        Logger.debug("\tSearching image assets files: started")
        let enumerator = fileManager.enumerator(atPath: path)
        while let element = enumerator?.nextObject() as? String  {
            if isAsset(element) {
                assets.append(path + "/" + element)
            }
        }
        Logger.debug("\tSearching image assets files: finished (\(assets.count) asset\\s found)")
        return assets
    }
    
    func isAsset(_ element : String) -> Bool {
        return element.hasSuffix(AssetsFinder.assetsSuffix)
    }
    
}
