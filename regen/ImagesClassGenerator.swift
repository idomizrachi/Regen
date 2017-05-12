//
//  ImagesClassGenerator.swift
//  regen
//
//  Created by Ido Mizrachi on 5/10/17.
//

import Foundation

protocol ImagesClassGenerator {
    func generateClass(fromImages images : [ImageAssetMetadata], generatedFile : String)
}
