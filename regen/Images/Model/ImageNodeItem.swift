//
//  ImageNodeItem.swift
//  regen
//
//  Created by Ido Mizrachi on 10/2/17.
//  Copyright © 2017 Ido Mizrachi. All rights reserved.
//

import Cocoa

//TODO: Rename
public class ImageNodeItem: Hashable {
    var folder: String = ""
    var folderClass: String = ""
    
    var images: [Property] = []

    public static func ==(lhs: ImageNodeItem, rhs: ImageNodeItem) -> Bool {
        return lhs.folder == rhs.folder
    }
    
    init(folder: String, folderClass: String) {
        self.folder = folder
        self.folderClass = folderClass
        self.images = []
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(folder)
    }
}
