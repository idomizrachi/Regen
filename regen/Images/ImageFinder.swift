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
    
    func findImages(in assets : String) -> [String] {
        var images : [String] = []
        var searchPath = assets
        if !assets.hasSuffix("/") {
            searchPath = searchPath + "/"
        }
        Logger.debug("\tSearching for images: started")
        let enumaretor = fileManager.enumerator(atPath: searchPath)
        while let element = enumaretor?.nextObject() as? String {            
            if isImage(element) {
                images.append(searchPath + element)
            }
        }
        Logger.debug("\tSearching for images: finished (\(images.count) image\\s found)")
        return images
    }

    func isImage(_ element : String) -> Bool {
        return element.hasSuffix(ImageFinder.imageSuffix)
    }
}
