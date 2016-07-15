//
//  main.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/7/16.
//  Copyright © 2016 Ido Mizrachi. All rights reserved.
//

import Foundation

if Process.arguments.contains("--version") {
    print("\(Version.current)")
    exit(EXIT_SUCCESS)
}

let usage = Usage()
usage.printUsage()

/*
var output : String = "Images"
let indexOfOutput = Process.arguments.indexOf("--output")
if indexOfOutput >= 0 {
    if indexOfOutput!+1 < Process.arguments.count {
        output = Process.arguments[indexOfOutput!+1]
    } else {
        print("Wrong format for --output parameter, please use Regen --output filename")
    }
}

let fileManager = NSFileManager.defaultManager()
let searchPath = fileManager.currentDirectoryPath

let assetsFinder = AssetsFinder(fileManager: fileManager)
let assets = assetsFinder.findAssets(inPath: searchPath)

let imageFinder = ImageFinder(fileManager: fileManager)
let imageAssetParser = ImageAssetParser()
var metadatas : [ImageAssetMetadata] = []

for asset in assets {
    let images = imageFinder.findImages(inAsset: asset)
    for image in images {
        let metadata = imageAssetParser.parseImage(image)
        metadatas.append(metadata)
    }
}

let validator = Validator()
let validationIssues = validator.validate(metadatas)
if validationIssues.count == 0 {
    let generator = ResourceesClassGenerator()
    generator.generateClass(fromImages: metadatas, generatedFile: output)
} else {
    for validationIssue in validationIssues {
        print("\(validationIssue.firstImage) conflicts with \(validationIssue.secondImage) for as property \(validationIssue.property)")
    }
    exit(EXIT_FAILURE)
}
*/
exit(EXIT_SUCCESS)