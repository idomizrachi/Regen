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
        let imageFinder = ImageFinder(fileManager: fileManager)
        let imagesetParser = ImagesetParser()
        var images : [Image] = []
        
        let xcassetsFiles = assetsFinder.findAssetsFiles(in: searchPath)
        for assetsFile in xcassetsFiles {
            let imageFiles = imageFinder.findImages(in: assetsFile)
            for imageFile in imageFiles {
                if let image = imagesetParser.parseImage(imageFile) {
                    images.append(image)
                }
            }
        }
        
        let imagesTree = foldersTree(images: images)
        
        let validator = ImagesValidator()
        let validationIssues = validator.validate(images)        
        if validationIssues.count == 0 {
            let generator: ImagesClassGenerator
            if self.language == .ObjC {
                generator = ImagesClassGeneratorObjC()
            } else {
                generator = ImagesClassGeneratorSwift()
            }            
            generator.generateClass(fromImagesTree: imagesTree, generatedFile: output)
        } else {
            Logger.error("Issues found:")
            for validationIssue in validationIssues {
                let firstImage = validationIssue.firstImage
                let secondImage = validationIssue.secondImage
                Logger.error("\timage \(firstImage) conflicts with \(secondImage) as property \(validationIssue.property)")
            }
            exit(EXIT_FAILURE)
        }
        Logger.info("Images scan: Finished")
    }
    
    func foldersTree(images: [Image]) -> Tree<ImageNodeItem> {
        let root = ImageNodeItem(folder: "", folderClass: "")
        let tree: Tree<ImageNodeItem> = Tree<ImageNodeItem>(item: root)
        for image in images {
            if image.folders.count == 0 {
                tree.item?.images.append(image.file)
            } else {
                var node: Node<ImageNodeItem> = tree
                var nextNode: Node<ImageNodeItem>? = nil
                for folder in image.folders {
                    var found = false
                    for child in node.children {
                        if child.item?.folder == folder.propertyName {
                            found = true
                            nextNode = child
                            break
                        }
                    }
                    if found == false {
                        let uuid = UUID().uuidString
                        let folderClass = folder.propertyName.className() + "_" + String(uuid[..<uuid.index(uuid.startIndex, offsetBy: 5)])
                        let folderNode: Node<ImageNodeItem> = Node(item: ImageNodeItem(folder: folder.propertyName, folderClass: folderClass))
                        node.addChild(folderNode)
                        node = folderNode
                    } else {
                        node = nextNode!
                    }
                }
                node.item?.images.append(image.file)
            }
        }
        
        return tree
    }
}
