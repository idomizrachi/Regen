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
        
        File.deleteFileAt(filePath: filename)
        
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
        
        /*
        headerFile += "@protocol \(generatedProtocol)\n"
        
        generateFoldersHeaderProperties(node: imagesTree, headerFile: &headerFile)
        
        headerFile += "\n"
        
        generateAssetsHeaderProperties(node: imagesTree, headerFile: &headerFile)
        
        headerFile += "@end\n"
        
        headerFile += "@interface \(className) : NSObject<\(generatedProtocol)>\n\n"
        
        implementationFile += "@implementation \(className)\n\n"
        
        headerFile += "+(id<\(generatedProtocol)>)sharedInstance;\n\n"
        implementationFile += """
        +(id<\(generatedProtocol)>)sharedInstance {
        static \(className) *_sharedInstance = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
        _sharedInstance = [\(className) new];
        });
        return _sharedInstance;
        }
        
        
        """
        generateFoldersProperties(node: imagesTree, headerFile: &headerFile, implementationFile: &implementationFile)
        headerFile += "\n"
        
        generateAssetsProperties(node: imagesTree, headerFile: &headerFile, implementationFile: &implementationFile)
        
        
        headerFile += "@end\n"
        implementationFile += "@end\n"
    */
        file += "}\n"
        
        File.append(filePath: filename, content: file)
        
        Logger.debug("\tGenerating images swift class: finished")
        Logger.info("\tCreated: \(filename)")
    }
   
    
    func generateClassX(node: TreeNode<ImageNodeItem>, file: inout String) {
        for folder in node.children {
            generateClassX(node: folder, file: &file)
        }
        
        file += "class \(node.item!.folderClass) {\n\n"
        
        generateFoldersProperties(node: node, file: &file)
        if (node.children.count > 0) {
            file += "\n"
        }
        generateAssetsProperties(node: node, file: &file)
        
        file += "}\n"
        
    }
    
    
    
    func generateFoldersProperties(node: TreeNode<ImageNodeItem>, file: inout String) {
        for folder in node.children {
            file += "    let \(folder.item!.folder.propertyName()) = \(folder.item!.folderClass)()\n"
        }
    }
    
    func generateAssetsProperties(node: TreeNode<ImageNodeItem>, file: inout String) {
        if let assets = node.item {
            for image in assets.images {
                file += "    let \(image.propertyName) = \"\(image.name)\"\n"
            }
        }
    }
}
