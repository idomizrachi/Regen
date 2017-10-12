//
//  Tree.swift
//  regen
//
//  Created by Ido Mizrachi on 10/3/17.
//  Copyright © 2017 Ido Mizrachi. All rights reserved.
//

import Cocoa

public class TreeNode<T> {
    public let item: T
    public private(set) var children: [TreeNode<T>] = []
    
    public init(item: T) {
        self.item = item
    }
    
    public func addChild(_ child: TreeNode<T>) {
        self.children.append(child)
    }
}

public class Tree<T>: TreeNode<T> {
}
