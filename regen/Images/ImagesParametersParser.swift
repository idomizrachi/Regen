//
//  ImagesParametersParser.swift
//  regen
//
//  Created by Ido Mizrachi on 24/07/2019.
//  Copyright © 2019 Ido Mizrachi. All rights reserved.
//

import Foundation

class ImagesParametersParser {
    let arguments: [String]

    init(arguments: [String]) {
        self.arguments = arguments
    }

    func parse() -> Images.Parameters? {
        guard let assetsFile: String = tryParse(.assetsFile, from: arguments) else {
            return nil
        }
        guard let templateFile: String = tryParse(.template, from: arguments) else {
            return nil
        }
        let outputFilename: String = tryParse(.outputFilename, from: arguments) ?? "Localization.swift"
        let outputClassName: String = tryParse(.outputClassName, from: arguments) ?? "Localization"
        return Images.Parameters(assetsFile: assetsFile, templateFile: templateFile, outputFilename: outputFilename, outputClassName: outputClassName)
    }
}
