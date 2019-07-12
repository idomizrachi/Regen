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
        let fileManager: FileManager

        init(parameters: Parameters, fileManager : FileManager = FileManager.default) {
            self.parameters = parameters
            self.fileManager = fileManager
        }

        func run() {
            let finder = Finder(searchPath: parameters.searchPath, stringsFilename: "Localizable.strings")
            let files = finder.findLocalizationFiles()
            let parser = Localization.Parser()
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
            //let context = LocalizationContext(className: "StringsX", properties: [
            //    LocalizationProperty(name: "hello_there", key: "ao", value: "vl"),
            //    LocalizationProperty(name: "hello_there2", key: "a2o", value: "vl4"),
            //])
            let data = try! JSONEncoder().encode(localizationEntries)
            let array = try! JSONSerialization.jsonObject(with: data, options: []) as! [AnyHashable]
            let context: [String: AnyHashable] = ["className": parameters.outputClassName, "properties": array]

            let environment = Environment(loader: FileSystemLoader(paths: [""]))
            let render = try! environment.renderTemplate(name: parameters.templateFilepath, context: context)
            try! render.data(using: .utf8)!.write(to: URL(fileURLWithPath: parameters.outputFilename))
            //
            //let data = try JSONEncoder().encode(context)
            //let dictionary = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
            //
            //let render = try environment.renderTemplate(name: "LocalizationSwiftTemplate.txt", context: dictionary)
            //print(render)
            //try! render.data(using: .utf8)?.write(to: URL(fileURLWithPath: "Gen.swift"))
        }

        //    func run(_ searchPath : String, output : String) {
        //        Logger.info("Localization scan: started")
        //        let localizationFinder = LocalizationFinder(fileManager: fileManager)
        //        let files = localizationFinder.findLocalizationFiles(inPath: searchPath)
        //        let parser = LocalizationParser()
        //        var localizationEntries : [LocalizationEntry] = []
        //        Logger.debug("\tParse localization files: started")
        //        for file in files {
        //            //Scanning only the english file saves a few seconds
        //            if file.hasSuffix("en.lproj/Localizable.strings") {
        //                let parsedFile = parser.parseLocalizationFile(file)
        //                parser.appendEntries(parsedFile, to: &localizationEntries)
        //            }
        //        }
        //        //TODO: Add validator for duplicated properties
        //        Logger.debug("\tParse localization files: finished (\(localizationEntries.count) keys found)")
        //        let generator: LocalizationClassGenerator
        //        switch language {
        //        case .objc:
        //            generator = LocalizationClassGeneratorObjC()
        //        case .swift:
        //            generator = LocalizationClassGeneratorSwift()
        //        }
        //        generator.generateClass(fromLocalizationEntries: localizationEntries, generatedFile: output)
        //        Logger.info("Localization scan: finished")
        //    }
    }



        //struct LocalizationProperty: Codable {
        //    let name: String
        //    let key: String
        //    let value: String
        //}
        //
        //struct LocalizationContext: Codable {
        //    let className: String
        //    let properties: [LocalizationProperty]
        //}
        //


}


