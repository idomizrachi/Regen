//
//  main.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/7/16.
//

import Foundation

let operationTimer = OperationTimer()
operationTimer.start()

let fileManager = FileManager.default
let argumentsParser = ArgumentsParser(arguments: CommandLine.arguments)
let operationType = argumentsParser.operationType()
let searchPath = fileManager.currentDirectoryPath

Logger.logLevel = argumentsParser.verbose ? .verbose : .info;
Logger.color = argumentsParser.color

switch operationType {
case .version:
    Version.printVersion()
case .images:
    Logger.info("Searching for images in path: \(searchPath)")
    let imageOperation = ImageOperation(fileManager: fileManager, language: argumentsParser.language)
    var output = "Images"
    if argumentsParser.output != nil {
        output = argumentsParser.output!
    }
    imageOperation.run(searchPath, output: output)
    let totalTime = String(format: "%.2f", operationTimer.end())
    Logger.info("Finish in \(totalTime) seconds")
case .localization:
    Logger.info("Searching for localization files in path: \(searchPath)")
    let localizationOperation = LocalizationOperation(fileManager: fileManager, language: argumentsParser.language)
    var output = "Strings"
    if argumentsParser.output != nil {
        output = argumentsParser.output!
    }
    localizationOperation.run(searchPath, output: output)
    let totalTime = String(format: "%.2f", operationTimer.end())
    Logger.info("Finish in \(totalTime) seconds")
default:
    let usage = Usage()
    usage.printUsage()
}

exit(EXIT_SUCCESS)
