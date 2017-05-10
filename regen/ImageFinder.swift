//
//  ImageFinder.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/8/16.
//

import Cocoa

class ImageFinder {
    static let imageSuffix = ".imageset"
    
    let fileManager : FileManager
    
    init(fileManager: FileManager) {
        self.fileManager = fileManager
    }
    
    func findImages(inAsset asset : String) -> [String] {
        var images : [String] = []
        var searchPath = asset
        if !asset.hasSuffix("/") {
            searchPath = searchPath + "/"
        }
        let enumaretor = fileManager.enumerator(atPath: searchPath)
        while let element = enumaretor?.nextObject() as? String {            
            if isImage(element) {
                images.append(searchPath + element)
            }
        }
        return images
    }

    func isImage(_ element : String) -> Bool {
        return element.hasSuffix(ImageFinder.imageSuffix)
    }
}
