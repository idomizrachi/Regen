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
        let fileManager: FileManager

        init(searchPath: String, stringsFilename: String, fileManager: FileManager = FileManager.default) {
            self.searchPath = searchPath
            self.stringsFilename = stringsFilename
            self.fileManager = fileManager
        }

        func findLocalizationFiles() -> [String] {
            let enumerator = fileManager.enumerator(atPath: searchPath)
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
