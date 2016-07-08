//
//  ImageFinder.swift
//  SafeAsset
//
//  Created by Ido Mizrachi on 7/8/16.
//  Copyright © 2016 Ido Mizrachi. All rights reserved.
//

import Cocoa

class ImageFinder {
    static let imageSuffix = ".imageset"
    
    let fileManager : NSFileManager
    
    init(fileManager: NSFileManager) {
        self.fileManager = fileManager
    }
    
    func findImages(inAsset asset : String) -> [String] {
        var images : [String] = []
        var searchPath = asset
        if !asset.hasSuffix("/") {
            searchPath = searchPath + "/"
        }
        let enumaretor = fileManager.enumeratorAtPath(searchPath)
        while let element = enumaretor?.nextObject() as? String {            
            if isImage(element) {
                images.append(searchPath + element)
            }
        }
        return images
    }

    func isImage(element : String) -> Bool {
        return element.hasSuffix(ImageFinder.imageSuffix)
    }
}
