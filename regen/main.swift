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



