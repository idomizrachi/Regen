//
//  LocalizationParams.swift
//  regen
//
//  Created by Ido Mizrachi on 14/07/2019.
//  Copyright © 2019 Ido Mizrachi. All rights reserved.
//

import Foundation

extension Localization {
    struct Parameters {
        let searchPath: String
        let templateFile: String
        let outputFilename: String
        let outputClassName: String
        let baseLanguageCode: String
        let parameterDetection: ParameterDetection?
        let whitelistFile: String?
    }

    // This is useful if you localization strings contains custom parameters, for example:
    // "Hello #{user}, you have #{unread_count} unread messages"
    // In this case:
    //  the start regex will detect #{
    //  the end regex will detect }
    //  the start offset will be 2
    //  the end offset will be 1
    struct ParameterDetection {
        let startRegex: String
        let endRegex: String
        let startOffset: Int
        let endOffset: Int
    }
}
