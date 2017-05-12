//
//  Logger.swift
//  regen
//
//  Created by Ido Mizrachi on 5/12/17.
//

import Foundation


public class Logger {
    
    public enum Level: Int {
        case verbose = 0
        case debug = 1
        case info = 2
        case warning = 3
        case error = 4
        case off = 5
    }
    
    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss.SSS"
        return formatter
    }()
    
    public static var logLevel: Level = .error
    

    public static func verbose(_ text: String) {
        log(text, level: .verbose)
    }
    
    public static func debug(_ text: String) {
        log(text.green.blackBackground, level: .debug)
    }
    
    public static func info(_ text: String) {
        log(text.white.blackBackground, level: .info)
    }
    
    public static func warning(_ text: String) {
        log(text.black.yellowBackground, level: .warning)
    }
    
    public static func error(_ text: String) {
        log(text.white.redBackground, level: .error)
    }
    
    private static func log(_ text: String, level: Level) {
        if shouldLog(level: level) == false {
            return
        }
        let date = formatter.string(from: Date())
        print("\(date) \(text)")
    }
    
    private static func shouldLog(level: Level) -> Bool {
        return level.rawValue >= Logger.logLevel.rawValue
    }
    
}
