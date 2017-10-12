//
//  ImagesClassGeneratorObjC.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/8/16.
//

import Cocoa



class ImagesClassGeneratorObjC: ImagesClassGenerator {
    func generateClass(fromImagesTree imagesTree: Tree<ImageNodeItem>, generatedFile: String) {
        
        Logger.debug("\tGenerating images objc class: started")
        
        let headerFilename = generatedFile + ".h"
        let implementationFilename = generatedFile + ".m"

        var headerFile = ""
        var implementationFile = ""
        
        File.deleteFileAt(filePath: headerFilename)
        File.deleteFileAt(filePath: implementationFilename)
        
        let className = String(NSString(string: generatedFile).lastPathComponent)
        let generatedProtocol = "\(className)Protocol"
 
        headerFile += "@import Foundation;\n\n"
        implementationFile += "@import Foundation;\n\n"
        implementationFile += "#import \"\(className).h\"\n"
        
        for folder in imagesTree.children {
            generateClassX(node: folder, headerFile: &headerFile, implementationFile: &implementationFile)
        }
        
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
                
        File.append(filePath: headerFilename, content: headerFile)
        File.append(filePath: implementationFilename, content: implementationFile)
        
        Logger.debug("\tGenerating images objc class: finished")
        Logger.info("\tCreated: \(headerFilename)")
        Logger.info("\tCreated: \(implementationFilename)")
    }
    
    func generateClassX(node: TreeNode<ImageNodeItem>, headerFile: inout String, implementationFile: inout String) {
        for folder in node.children {
            generateClassX(node: folder, headerFile: &headerFile, implementationFile: &implementationFile)
        }
        
        let generatedProtocol = "\(node.item!.folderClass)Protocol"
        headerFile += "@protocol \(generatedProtocol)\n"
        
        implementationFile += "@implementation \(node.item!.folderClass)\n\n"
        
        generateFoldersProperties(node: node, headerFile: &headerFile, implementationFile: &implementationFile)
        headerFile += "\n"
        
        generateAssetsProperties(node: node, headerFile: &headerFile, implementationFile: &implementationFile)
        
        headerFile += "@end\n"
        headerFile += "@interface \(node.item!.folderClass) : NSObject<\(generatedProtocol)>\n\n"
        generateFoldersHeaderProperties(node: node, headerFile: &headerFile)
        
        headerFile += "@end\n"
        implementationFile += "@end\n"
    }


    
    func generateFoldersProperties(node: TreeNode<ImageNodeItem>, headerFile: inout String, implementationFile: inout String) {
        generateFoldersHeaderProperties(node: node, headerFile: &headerFile)
        for folder in node.children {
            implementationFile += """
            -(id<\(folder.item!.folderClass)Protocol>)\(folder.item!.folder.propertyName()) {
                if (! _\(folder.item!.folder.propertyName())) {
                    _\(folder.item!.folder.propertyName()) = [[\(folder.item!.folderClass) alloc] init];
                }
                return _\(folder.item!.folder.propertyName());
            }
            
            """
        }
    }
    
    func generateFoldersHeaderProperties(node: TreeNode<ImageNodeItem>, headerFile: inout String) {
        for folder in node.children {
            headerFile += "@property (nonatomic, strong) id<\(folder.item!.folderClass)Protocol> \(folder.item!.folder.propertyName());\n"
        }
    }
    
    func generateAssetsProperties(node: TreeNode<ImageNodeItem>, headerFile: inout String, implementationFile: inout String) {
        if let assets = node.item {
            for image in assets.images {
                headerFile += "@property (nonatomic, strong, readonly) NSString *\(image.propertyName);\n"
                implementationFile += """
                -(NSString *)\(image.propertyName) {
                    return @"\(image.name)";
                }
                
                
                """
            }
        }
    }
    
    func generateAssetsHeaderProperties(node: TreeNode<ImageNodeItem>, headerFile: inout String) {
        if let assets = node.item {
            for image in assets.images {
                headerFile += "@property (nonatomic, strong, readonly) NSString *\(image.propertyName);\n"
            }
        }
    }
    
    
}
