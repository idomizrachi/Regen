	//
//  File.swift
//  regen
//
//  Created by Ido Mizrachi on 10/9/17.
//  Copyright © 2017 Ido Mizrachi. All rights reserved.
//

import Cocoa

class FileUtils {
    //Create a new file is does not exists
    static func append(filePath: String, content: String) {
        do {
            try FileManager.default.createDirectory(atPath: NSString(string: filePath).deletingLastPathComponent, withIntermediateDirectories: true, attributes: nil)
        } catch {
            Logger.error("Failed to create path for \(filePath)")
            return
        }
        if let fileHandle = FileHandle(forWritingAtPath: filePath) {
            fileHandle.seekToEndOfFile()
            if let data = content.data(using: String.Encoding.utf8) {
                fileHandle.write(data)
            }
            fileHandle.closeFile()
            
        } else {
            do {
                try content.write(toFile: filePath, atomically: false, encoding: String.Encoding.utf8)
            } catch let error {
                Logger.error("Failed to create file \(filePath).\nError: \(error)")
            }
        }
    }
    
    static func deleteFileAt(filePath: String) {
        if FileManager.default.fileExists(atPath: filePath) {
            do {
                try FileManager.default.removeItem(atPath: filePath)
            } catch {
                Logger.error("Failed to delete file \(filePath)")
            }
        }
    }
}
