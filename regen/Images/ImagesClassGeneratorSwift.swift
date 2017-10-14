//
//  ImagesClassGeneratorSwift.swift
//  regen
//
//  Created by Ido Mizrachi on 5/10/17.
//

import Foundation

class ImagesClassGeneratorSwift: ImagesClassGenerator {
    
    func generateClass(fromImagesTree imagesTree: Tree<ImageNodeItem>, generatedFile: String) {
        
        Logger.debug("\tGenerating images swift class: started")
        
        let filename = generatedFile + ".swift"
        
        var file = ""
        
        FileUtils.deleteFileAt(filePath: filename)
        
        let className = String(NSString(string: generatedFile).lastPathComponent)
        
        file += "import Foundation\n\n"
        
        
        for folder in imagesTree.children {
            generateClassX(node: folder, file: &file)
        }
        
        file += "\n"
        file += "class \(className) {\n"
        file += "    static let shared = \(className)()\n"
        file += "    private init() {}\n"
        
        file += "\n"
        generateFoldersProperties(node: imagesTree, file: &file)
        file += "\n"
        generateAssetsProperties(node: imagesTree, file: &file)
        file += "}\n"
        
        FileUtils.append(filePath: filename, content: file)
        
        Logger.debug("\tGenerating images swift class: finished")
        Logger.info("\tCreated: \(filename)")
    }
   
    
    func generateClassX(node: TreeNode<ImageNodeItem>, file: inout String) {
        for folder in node.children {
            generateClassX(node: folder, file: &file)
        }
        
        file += "class \(node.item.folderClass) {\n\n"
        
        generateFoldersProperties(node: node, file: &file)
        if (node.children.count > 0) {
            file += "\n"
        }
        generateAssetsProperties(node: node, file: &file)
        
        file += "}\n"
        
    }
    
    
    
    func generateFoldersProperties(node: TreeNode<ImageNodeItem>, file: inout String) {
        for folder in node.children {
            file += "    let \(folder.item.folder.propertyName()) = \(folder.item.folderClass)()\n"
        }
    }
    
    func generateAssetsProperties(node: TreeNode<ImageNodeItem>, file: inout String) {
        for image in node.item.images {
            file += "    let \(image.propertyName) = \"\(image.name)\"\n"
        }
    }
}
