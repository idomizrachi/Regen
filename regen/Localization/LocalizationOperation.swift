//
//  LocalizationOperation.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/15/16.
//

import Foundation

extension Localization {
    class Operation {
        
        let parameters: Parameters

        init(parameters: Parameters) {
            self.parameters = parameters
        }

        func run() {
            let finder = Finder(searchPath: parameters.searchPath, stringsFilename: "Localizable.strings")
            let files = finder.findLocalizationFiles()
            let whitelist = parseWhitelist()
            let parser = Localization.Parser(parameterDetection: parameters.parameterDetection, whitelist: whitelist)
            guard let baseLanguageFile = files.first(where: { $0.hasSuffix(parameters.baseLanguageCode + ".lproj/Localizable.strings")}) else {
                //error
                return
            }
            var localizationEntries: [Entry] = []
            localizationEntries.append(contentsOf: parser.parseLocalizationFile(baseLanguageFile))
            let duplicates = findDuplicates(localizationEntries: localizationEntries)
            guard duplicates.isEmpty else {
                duplicates.forEach { print($0) }
                return
            }
            generate(localizationEntries: localizationEntries)

        }

        private func findDuplicates(localizationEntries: [Entry]) -> [String] {
            var duplicatesReport: [String] = []
            var scanner = localizationEntries
            while !scanner.isEmpty {
                let entry = scanner.removeFirst()
                if let duplicate = scanner.first(where: { $0.property == entry.property }) {
                    duplicatesReport.append("Duplicate - key:\(entry.key) value:\(entry.value) property name:\(entry.property)")
                    duplicatesReport.append("With - key:\(duplicate.key) value:\(duplicate.value) property name:\(duplicate.property)")
                }
            }
            return duplicatesReport
        }

        private func generate(localizationEntries: [Entry]) {
            let data = try! JSONEncoder().encode(localizationEntries)
            let array = try! JSONSerialization.jsonObject(with: data, options: []) as! [AnyHashable]
            let context: [String: AnyHashable] = ["className": parameters.outputClassName, "properties": array]

            let environment = Environment(loader: FileSystemLoader(paths: [""]))
            let render = try! environment.renderTemplate(name: parameters.templateFile, context: context)
            try! render.data(using: .utf8)!.write(to: URL(fileURLWithPath: parameters.outputFilename))
        }

        private func parseWhitelist() -> [String]? {
            guard let whitelistFile = parameters.whitelistFile else {
                return nil
            }
            do {
                let whitelistString = try String(contentsOfFile: whitelistFile)
                let whitelistArray = whitelistString.split(separator: "\n").compactMap {
                    return String($0).trimmingCharacters(in: .whitespacesAndNewlines)
                }
                return whitelistArray
            } catch {
                print("Could not load whitelist from \(whitelistFile)")
                return nil
            }
        }
    }
    
}


