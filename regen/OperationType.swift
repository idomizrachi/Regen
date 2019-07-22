//
//  ScanType.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/15/16.
//

import Foundation

enum OperationType {
    // Info
    case version
    case usage
    // Actions
    case images(parameters: ImagesParameters)
    case localization(parameters: Localization.Parameters)
}

extension OperationType {
    enum Keys: String {
        case version = "--version"
        case usage
        case images
        case localization
    }
}
