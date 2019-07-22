//
//  CommandLineParameter.swift
//  regen
//
//  Created by Ido Mizrachi on 17/07/2019.
//  Copyright © 2019 Ido Mizrachi. All rights reserved.
//

import Foundation

enum CommandLineParameter: String {
    case searchPath = "--search-path"
    case template = "--template"
    case outputFilename = "--output-filename"
    case outputClassName = "--output-class-name"
    case baseLanguageCode = "--base-language-code"
    case whitelist = "--whitelist-filename"
    case parameterStartRegex = "--parameter-start-regex"
    case parameterEndRegex = "--parameter-end-regex"
    case parameterStartOffset = "--parameter-start-offset"
    case parameterEndOffset = "--parameter-end-offset"
}
