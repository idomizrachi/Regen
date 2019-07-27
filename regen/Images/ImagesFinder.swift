//
//  ImageFinder.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/8/16.
//

import Cocoa

extension Images {
    class ImagesetsFinder {

        init() {
        }

        func find(in assets : String) -> [String] {
            var images : [String] = []
            var searchPath = assets
            if !assets.hasSuffix("/") {
                searchPath = searchPath + "/"
            }
//            Logger.debug("\tSearching for images: started")
            let enumaretor = FileManager.default.enumerator(atPath: searchPath)
            while let element = enumaretor?.nextObject() as? String {
                if isImageset(element) {
                    images.append(searchPath + element)
                }
            }
//            Logger.debug("\tSearching for images: finished (\(images.count) image\\s found)")
            return images
        }

        func isImageset(_ element : String) -> Bool {
            return element.hasSuffix(Images.imagesetSuffix)
        }
    }
}
