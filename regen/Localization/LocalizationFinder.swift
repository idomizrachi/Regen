//
//  LocalizationFinder.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/15/16.
//

import Foundation

extension Localization {
    class Finder {

        let searchPath: String
        let stringsFilename: String

        init(searchPath: String, stringsFilename: String) {
            self.searchPath = searchPath
            self.stringsFilename = stringsFilename
        }

        func findLocalizationFiles() -> [String] {
            let enumerator = FileManager.default.enumerator(atPath: searchPath)
            var localizationFiles : [String] = []
            while let element = enumerator?.nextObject() as? String  {
                if element.hasSuffix(stringsFilename) {
                    localizationFiles.append(searchPath + "/" + element)
                }
            }
            return localizationFiles
        }

    }
}
