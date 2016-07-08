//
//  main.swift
//  SafeAsset
//
//  Created by Ido Mizrachi on 7/7/16.
//  Copyright © 2016 Ido Mizrachi. All rights reserved.
//

import Foundation

let fileManager = NSFileManager.defaultManager()
let searchPath = fileManager.currentDirectoryPath

let assetsFinder = AssetsFinder(fileManager: fileManager)
let assets = assetsFinder.findAssets(inPath: searchPath)

let imageFinder = ImageFinder(fileManager: fileManager)
let imageAssetParser = ImageAssetParser()
var metadatas : [ImageAssetMetadata] = []

for asset in assets {
    print("\(asset)")
    let images = imageFinder.findImages(inAsset: asset)
    for image in images {
        let metadata = imageAssetParser.parseImage(image)
        metadatas.append(metadata)
    }
}

let generator = ResourceesClassGenerator()
generator.generateClass(fromImages: metadatas, generatedFile: "Images")
