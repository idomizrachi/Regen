//
//  Usage.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/15/16.
//

import Foundation


// Usage:
// regen supports two type of code generation:
// 1. Images - by scanning ".xcassets" packages
// 2. Localization - by scanning string files
//
// Type any of the following for additiona help:
// regen images --help
// regen localization --help

class Usage {

    static func display() {
        let usage = #"""
        Usage:
            $ regen localization [options]
            or
            $ regen images [options]
            or

        General:
            --version                   Prints the current tool version

        Localization Parameters:
            --search-path               The path of the .strings files, for example: /Users/me/dev/project
            --template                  Stencil template file, for example: Template.txt
            --output-filename           The output filename, for example: Localization.swift, default value: Localization.swift
            --output-class-name         The generated class name, for example: LocalizableStrings, default value: Localization
            --base-language-code        The locate of the .strings file that will be scanned, default value: en
            --whitelist-filename        If specified, the file with a list of strings keys to include in the generated file
            Handling Localization Parameters: "hello %d" / "Welcome #{user}"
            --parameter-start-regex     The regex for the beginning of the parameters, in the above cases a regex for % or #{
            --parameter-end-regex       The regex for the beginning of the parameters, in the above cases a regex for d or }
            --parameter-start-offset    The number of characters to skip when a parameter for example to extract only "user" from #{users} skip 1 character
            --parameter-end-offset      The number of characters to skip when a parameter for example to extract only "user" from #{users} skip 2 characters from the end

        Images Parameters:
            --template      Set the Stencil template file
            --output         Set the output file
        """#


        print(usage)
    }
}
