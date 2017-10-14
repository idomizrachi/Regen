//
//  main.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/7/16.
//

import Foundation

class Main {
    
    private let fileManager: FileManager = FileManager.default
    
    public func run() {
        var skipOperationTimePrint:Bool = false
        let operationTimer = OperationTimer()
        operationTimer.start()
        
        let argumentsParser = ArgumentsParser(arguments: CommandLine.arguments)
        let operationType = argumentsParser.operationType()
        let path =  fileManager.currentDirectoryPath
        
        Logger.logLevel = argumentsParser.verbose ? .verbose : .info;
        Logger.color = argumentsParser.color
        
        switch operationType {
        case .version:
            skipOperationTimePrint = true
            Version.display()
            
        case .images:
            self.runImageOperation(inPath: path, language: argumentsParser.language, nullableOutputFile: argumentsParser.output)
            
        case .localization:
            self.runLocalizationOperation(inPath: path, language: argumentsParser.language, nullableOutputFile: argumentsParser.output)
            
        default:
            skipOperationTimePrint = true
            Usage.display(color: argumentsParser.color)
        }
        
        if skipOperationTimePrint == false {
            let totalTime = String(format: "%.2f", operationTimer.end())
            Logger.info("Finish in \(totalTime) seconds")
        }
        
        exit(EXIT_SUCCESS)
    }
    
    private func runImageOperation(inPath: String, language: Language, nullableOutputFile: String?) {
        Logger.info("Searching for images in path: \(inPath)")
        let imageOperation = ImageOperation(fileManager: fileManager, language: language)
        let outputFile: String
        if let nonNilOutputFile = nullableOutputFile {
            outputFile = nonNilOutputFile
        } else {
            outputFile = "Images"
        }
        imageOperation.run(inPath, output: fileManager.currentDirectoryPath + "/" + outputFile)
    }
    
    private func runLocalizationOperation(inPath: String, language: Language, nullableOutputFile: String?) {
        Logger.info("Searching for localization files in path: \(inPath)")
        let localizationOperation = LocalizationOperation(fileManager: fileManager, language: language)
        let outputFile: String
        if let nonNilOutputFile = nullableOutputFile {
            outputFile = nonNilOutputFile
        } else {
            outputFile = "Strings"
        }
        localizationOperation.run(inPath, output: fileManager.currentDirectoryPath + "/" + outputFile)
        
    }
}

let main = Main()
main.run()

