//
//  main.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/7/16.
//  Copyright © 2016 Ido Mizrachi. All rights reserved.
//

import Foundation

let argumentsParser = ArgumentsParser(arguments: Process.arguments)
let operationType = argumentsParser.operationType()

switch operationType {
case .Version:
    Version.printVersion()
case .Images:
    let imageOperation = ImageOperation()
    if argumentsParser.output == nil{
        imageOperation.run()
    } else {
        imageOperation.run(argumentsParser.output!)
    }
case .Localization:
    let localizationOperation = LocalizationOperation()
    if argumentsParser.output == nil {
        localizationOperation.run()
    } else {
        localizationOperation.run(argumentsParser.output!)
    }
default:
    let usage = Usage()
    usage.printUsage()
}

exit(EXIT_SUCCESS)