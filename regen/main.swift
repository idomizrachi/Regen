//
//  main.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/7/16.
//  Copyright © 2016 Ido Mizrachi. All rights reserved.
//

import Foundation

let fileManager = NSFileManager.defaultManager()
let argumentsParser = ArgumentsParser(arguments: Process.arguments)
let operationType = argumentsParser.operationType()
let searchPath = fileManager.currentDirectoryPath
switch operationType {
case .Version:
    Version.printVersion()
case .Images:
    let imageOperation = ImageOperation(fileManager: fileManager)
    var output = "Images"
    if argumentsParser.output != nil{
        output = argumentsParser.output!
    }
    imageOperation.run(searchPath, output: output)
case .Localization:
    let localizationOperation = LocalizationOperation(fileManager: fileManager)
    var output = "Strings"
    if argumentsParser.output != nil {
        output = argumentsParser.output!
    }
    localizationOperation.run(searchPath, output: output)
default:
    let usage = Usage()
    usage.printUsage()
}

exit(EXIT_SUCCESS)