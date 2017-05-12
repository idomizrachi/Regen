//
//  ImageOperation.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/15/16.
//

import Foundation

class ImageOperation {
    let fileManager : FileManager
    let language: Language
    
    init(fileManager : FileManager, language: Language) {
        self.fileManager = fileManager
        self.language = language
    }
    
    func run(_ searchPath : String, output : String) {
        Logger.info("Images scan: started")
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
        
        let validator = ImagesValidator()
        let validationIssues = validator.validate(metadatas)
        if validationIssues.count == 0 {
            let generator: ImagesClassGenerator
            if self.language == .ObjC {
                generator = ImagesClassGeneratorObjC()
            } else {
                generator = ImagesClassGeneratorSwift()
            }
            generator.generateClass(fromImages: metadatas, generatedFile: output)
        } else {
            Logger.error("Issues found:".bold.underline)
            for validationIssue in validationIssues {
                let image = "image "
                let firstImage = validationIssue.firstImage.bold
                let conflicts = " conflicts with ".boldOff
                let secondImage = validationIssue.secondImage.bold
                let asProperty = " as property ".boldOff +  "\(validationIssue.property)".bold
                Logger.error("\t\(image)\(firstImage)\(conflicts)\(secondImage)\(asProperty)")
            }
            exit(EXIT_FAILURE)
        }
        Logger.info("Images scan: Finished")
    }
}
