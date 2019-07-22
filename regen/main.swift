//  
//  main.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/7/16.
//

import Foundation

let operationTimer = OperationTimer()
operationTimer.start()

let arguments = Array(CommandLine.arguments.dropFirst())
//let arguments = ["localization", "--search-path", "/Users/idomizrachi/dev/bringg/ios/ios-driver-app-2.0/BringgDriverApp2/Resources/Translations", "--template", "ParametersLocalizationTemplate.swift", "--output-filename", "Localization.swift", "--output-class-name", "SomeLocalization", "--base-language-code", "en", "--parameter-start-regex", "#\\{", "--parameter-end-regex", "\\}", "--parameter-start-offset", "2", "--parameter-end-offset", "1", "--whitelist", "whitelist.txt"]

let argumentsParser = ArgumentsParser(arguments: arguments)
switch argumentsParser.operationType {
case .version:
    Version.display()
case .usage:
    Usage.display()
case .localization(let parameters):
    let operation = Localization.Operation(parameters: parameters)
    operation.run()
    print("Finished in: \(String(format: "%.5f", operationTimer.end())) seconds.")
case .images(let parameters):
    let operation = Images.Operation(parameters: parameters)
    operation.run()
    print("Finished in: \(String(format: "%.5f", operationTimer.end())) seconds.")
}



