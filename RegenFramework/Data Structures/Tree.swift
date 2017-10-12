//
//  Tree.swift
//  regen
//
//  Created by Ido Mizrachi on 10/3/17.
//  Copyright © 2017 Ido Mizrachi. All rights reserved.
//

import Cocoa

public class Node<T> {
    public let item: Optional<T>
    public private(set) var children: [Node<T>] = []
    
    public init(item: Optional<T>) {
        self.item = item
    }
    
    public func addChild(_ child: Node<T>) {
        self.children.append(child)
    }
}

public class Tree<T>: Node<T> {
}
