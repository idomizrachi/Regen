//
//  ImagesOperation.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/15/16.
//

import Foundation

extension Images {
    class Operation {

        let parameters: Parameters

        init(parameters: Parameters) {
            self.parameters = parameters
        }

        func run() {
            let imagesetsFinder = ImagesetsFinder()
            let imagesetParser = ImagesetParser()
            var images : [Image] = []
            let imagesetFiles = imagesetsFinder.find(in: parameters.assetsFile)
            for imagesetFile in imagesetFiles {
                if let image = imagesetParser.parse(imagesetFile) {
                    images.append(image)
                }
            }
            let validator = Validator()
            let issues = validator.validate(images)
            guard issues.isEmpty else {
                return
            }
            let imagesTree = foldersTree(images: images)

            let result = generate(tree: imagesTree)
            try! result.data(using: .utf8)!.write(to: URL(fileURLWithPath: parameters.outputFilename))
//            generate()
////            if validationIssues.count == 0 {
////                let generator: ImagesClassGenerator
////                switch self.language {
////                case .objc:
////                    generator = ImagesClassGeneratorObjC()
////                case .swift:
////                    generator = ImagesClassGeneratorSwift()
////                }
////                generator.generateClass(fromImagesTree: imagesTree, generatedFile: output)
////            } else {
////                Logger.error("Issues found:")
////                for validationIssue in validationIssues {
////                    let firstImage = validationIssue.firstImage
////                    let secondImage = validationIssue.secondImage
////                    Logger.error("\timage \(firstImage) conflicts with \(secondImage) as property \(validationIssue.property)")
////                }
////                exit(EXIT_FAILURE)
////            }
////            Logger.info("Images scan: Finished")
        }

        private func generate(root: Tree<ImageNodeItem>) {
//            let data = try! JSONEncoder().encode(imagesTree)
//            let array = try! JSONSerialization.jsonObject(with: data, options: []) as! [AnyHashable]
//
//            let context: [String: AnyHashable] = ["className": parameters.outputClassName, "properties": array]
//
//            let environment = Environment(loader: FileSystemLoader(paths: [""]))
//            let render = try! environment.renderTemplate(name: parameters.templateFile, context: context)
//            try! render.data(using: .utf8)!.write(to: URL(fileURLWithPath: parameters.outputFilename))
        }

        /**
         public struct {{ className }} {
         {% for folder in folders %} let {{ folder.propertyName }}: {{folder.className }} = {{folder.className }}()

         {% for image in images %} let {{ image.propertyName }}: String = "{{ image.imageSetName }}"
         }

 */
        private func generate(tree: Tree<ImageNodeItem>) -> String {
            //flatten the tree
            //generate code per section
            //construct a single file
            let folders: [[String: String]] = tree.children.map {
                let folder: [String: String] = [
                    "propertyName": $0.item.folder.propertyName(),
                    "className": $0.item.folderClass
                ]
                return folder
            }
            let images: [[String: String]] = tree.item.images.map {
                let image: [String: String] = [
                    "propertyName": $0.propertyName,
                    "imageSetName": $0.name

                ]
                return image
            }
            let context: [String: AnyHashable] = [
                "className": parameters.outputClassName,
                "folders": folders,
                "images": images
            ]
            let environment = Environment(loader: FileSystemLoader(paths: [""]))
            let render = try! environment.renderTemplate(name: parameters.templateFile, context: context)
            let result = String(data: render.data(using: .utf8)!, encoding: .utf8)!
            var childrenGenerated: String = ""
            tree.children.forEach {
                childrenGenerated += generateChild(tree: $0, parent: parameters.outputClassName) + "\n"
            }

            return childrenGenerated + "\n" + result
        }

        private func generateChild(tree: TreeNode<ImageNodeItem>, parent: String) -> String {
            let folders: [[String: String]] = tree.children.map {
                let folder: [String: String] = [
                    "propertyName": $0.item.folder.propertyName(),
                    "className": $0.item.folderClass
                ]
                return folder
            }
            let images: [[String: String]] = tree.item.images.map {
                let image: [String: String] = [
                    "propertyName": $0.propertyName,
                    "imageSetName": $0.name

                ]
                return image
            }
            let context: [String: AnyHashable] = [
                "parent": parent,
                "className": tree.item.folderClass,
                "folders": folders,
                "images": images
            ]
            let environment = Environment(loader: FileSystemLoader(paths: [""]))
            let render = try! environment.renderTemplate(name: parameters.templateFile, context: context)
            let result = String(data: render.data(using: .utf8)!, encoding: .utf8)!

            var childrenGenerated: String = ""
            tree.children.forEach {
                childrenGenerated += generateChild(tree: $0, parent: tree.item.folderClass)
//                childrenGenerated += "\n"
            }
            return childrenGenerated + /*"\n\n" +*/ result
        }

        func foldersTree(images: [Image]) -> Tree<ImageNodeItem> {
            let root = ImageNodeItem(folder: "", folderClass: "")
            let tree: Tree<ImageNodeItem> = Tree<ImageNodeItem>(item: root)
            for image in images {
                if image.folders.count == 0 {
                    tree.item.images.append(image.file)
                } else {
                    var node: TreeNode<ImageNodeItem> = tree
                    var nextNode: TreeNode<ImageNodeItem>? = nil
                    for folder in image.folders {
                        var found = false
                        for child in node.children {
                            if child.item.folder == folder.propertyName {
                                found = true
                                nextNode = child
                                break
                            }
                        }
                        if found == false {
                            let folderClass = folder.propertyName.className()
                            let folderNode: TreeNode<ImageNodeItem> = TreeNode(item: ImageNodeItem(folder: folder.propertyName, folderClass: folderClass))
                            node.addChild(folderNode)
                            node = folderNode
                        } else {
                            node = nextNode!
                        }
                    }
                    node.item.images.append(image.file)
                }
            }

            return tree
        }
    }
}


