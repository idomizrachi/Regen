//
//  ImagesClassGenerator.swift
//  regen
//
//  Created by Ido Mizrachi on 5/10/17.
//

import Foundation

protocol ImagesClassGenerator {
    func generateClass(fromImagesTree imagesTree : Tree<ImageNodeItem>, generatedFile : String)
}
