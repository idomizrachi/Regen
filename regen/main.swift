//
//  main.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/7/16.
//

import Foundation

let fileManager = FileManager.default
let argumentsParser = ArgumentsParser(arguments: CommandLine.arguments)
let operationType = argumentsParser.operationType()
let searchPath = fileManager.currentDirectoryPath
switch operationType {
case .version:
    Version.printVersion()
case .images:
    let imageOperation = ImageOperation(fileManager: fileManager, language: argumentsParser.language)
    var output = "Images"
    if argumentsParser.output != nil {
        output = argumentsParser.output!
    }
    imageOperation.run(searchPath, output: output)
case .localization:
    let localizationOperation = LocalizationOperation(fileManager: fileManager, language: argumentsParser.language)
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
