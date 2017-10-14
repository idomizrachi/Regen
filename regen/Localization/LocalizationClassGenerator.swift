//
//  LocalizationClassGenerator.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/16/16.
//
import Foundation

protocol LocalizationClassGenerator {
    func generateClass(fromLocalizationEntries localization : [LocalizationEntry], generatedFile : String)
}
