//  test
//  main.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/7/16.
//

import Foundation

//class Main {
//
//    private let fileManager: FileManager = FileManager.default
//
//    public func run() {
//        var skipOperationTimePrint:Bool = false
//        let operationTimer = OperationTimer()
//        operationTimer.start()
//
//        let argumentsParser = ArgumentsParser(arguments: CommandLine.arguments)
//        let operationType = OperationType.localization//argumentsParser.operationType()
//        let path =  "/Users/idomizrachi/dev/bringg/ios/ios-driver-app-2.0/BringgDriverApp2/Resources/Translations" //fileManager.currentDirectoryPath
//
//        Logger.logLevel = .debug//argumentsParser.verbose ? .verbose : .info;
//        Logger.color = false//argumentsParser.color
//
//        argumentsParser.language = .Swift
//        argumentsParser.output = "Strings"
//
//        switch operationType {
//        case .version:
//            skipOperationTimePrint = true
//            Version.display()
//
//        case .images:
//            self.runImageOperation(inPath: path, language: argumentsParser.language, nullableOutputFile: argumentsParser.output)
//
//        case .localization:
//            self.runLocalizationOperation(inPath: path, language: argumentsParser.language, nullableOutputFile: argumentsParser.output)
//
//        default:
//            skipOperationTimePrint = true
//            Usage.display(color: argumentsParser.color)
//        }
//
//        if skipOperationTimePrint == false {
//            let totalTime = String(format: "%.2f", operationTimer.end())
//            Logger.info("Finish in \(totalTime) seconds")
//        }
//
//        exit(EXIT_SUCCESS)
//    }
//
//    private func runImageOperation(inPath: String, language: Language, nullableOutputFile: String?) {
//        Logger.info("Searching for images in path: \(inPath)")
//        let imageOperation = ImageOperation(fileManager: fileManager, language: language)
//        let outputFile: String
//        if let nonNilOutputFile = nullableOutputFile {
//            outputFile = nonNilOutputFile
//        } else {
//            outputFile = "Images"
//        }
//        imageOperation.run(inPath, output: fileManager.currentDirectoryPath + "/" + outputFile)
//    }
//
//    private func runLocalizationOperation(inPath: String, language: Language, nullableOutputFile: String?) {
//        Logger.info("Searching for localization files in path: \(inPath)")
//        let localizationOperation = LocalizationOperation(fileManager: fileManager, language: language)
//        let outputFile: String
//        if let nonNilOutputFile = nullableOutputFile {
//            outputFile = nonNilOutputFile
//        } else {
//            outputFile = "Strings"
//        }
//        localizationOperation.run(inPath, output: fileManager.currentDirectoryPath + "/" + outputFile)
//
//    }
//}



//let main = Main()
//main.run()

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
//let context = LocalizationContext(className: "StringsX", properties: [
//    LocalizationProperty(name: "hello_there", key: "ao", value: "vl"),
//    LocalizationProperty(name: "hello_there2", key: "a2o", value: "vl4"),
//])
//let environment = Environment(loader: FileSystemLoader(paths: ["./"]))
//
//let data = try JSONEncoder().encode(context)
//let dictionary = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
//
//let render = try environment.renderTemplate(name: "LocalizationSwiftTemplate.txt", context: dictionary)
//print(render)
//try! render.data(using: .utf8)?.write(to: URL(fileURLWithPath: "Gen.swift"))

//let usage = Usage(commandLineArguments: CommandLine.arguments)

let operationTimer = OperationTimer()
operationTimer.start()

let arguments = Array(CommandLine.arguments.dropFirst())
//let arguments = ["localization", "--search-path", "/Users/idomizrachi/dev/bringg/ios/ios-driver-app-2.0/BringgDriverApp2/Resources/Translations", "--template", "LocalizationSwiftTemplate.txt", "--output-filename", "Localization.swift", "--output-class-name", "SomeLocalization", "--base-language-code", "en"]

let argumentsParser = ArgumentsParser(arguments: arguments)
switch argumentsParser.operationType {
case .version:
    Version.display()
case .usage:
    Usage.display()
case .localization(let parameters):
    let operation = Localization.Operation(parameters: parameters)
    operation.run()
case .images(let parameters):
    let operation = ImagesOperation(parameters: parameters)
    operation.run()
}

let duration = operationTimer.end()
print("Took: \(duration) seconds.")

