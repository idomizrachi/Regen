//
//  ScanType.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/15/16.
//

import Foundation

extension Localization {
    struct Parameters {
        let searchPath: String
        let templateFilepath: String
        let outputFilename: String
        let outputClassName: String
        let baseLanguageCode: String
    }
}

struct ImagesParameters {
    let templateFilepath: String
    let outputFilename: String
}

enum OperationType {
    // Info
    case version
    case usage
    // Actions
    case images(parameters: ImagesParameters)
    case localization(parameters: Localization.Parameters)
}

enum OperationTypeKeys: String {
    case version = "--version"
    case usage
    case images
    case localization
}
