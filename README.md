# Regen
Regen generates objective-c\swift code for accessing your images and localized string.

## Installation

For the first time installation add the custom repo using `brew tap`:

`brew tap idomizrachi/regen`

Install regen:

`brew install regen`

Verify installation:

`regen --version`

or

`regen`

## What's New
### 0.0.10
Images and localization code is now generated based on a stencil templated instead of hardcoded

### 0.0.9
Fix issue in localization generated file of wrong class/struct name

### 0.0.8
Fix project install configuration.

### 0.0.7
Images generated class reflects the xcassets folders hierarchy

The images generated class reflects the folders hierarchy of the .xcassets file.

For example:

Images.xcassets -> Icons/logo

will be generated as:

`Images.sharedInstance.icons.logo`

for objective-c

and will be generated as:

`Images.shared.icons.logo`

for swift

### 0.0.6
Improve generated property names

Added new parameter to remove console color

Run localization operation only on the english strings file to save time

Update color codes

### 0.0.5
Added swift generated files

Print additional information during the execution using "-v" or "--verbose"

## Integration
Add new build phases:
![alt text](https://raw.githubusercontent.com/idomizrachi/Regen/master/Screenshots/Build%20Phases.png "Build Phases")

![alt text](https://github.com/idomizrachi/Regen/raw/master/Screenshots/Build%20Phase%20-%20images.png "Build Phase - Images")

![alt text](https://github.com/idomizrachi/Regen/raw/master/Screenshots/Build%20Phase%20-%20localization.png "Build Phase - Localization")

Build once to generate the files

Add the generated files to your project, make sure to **uncheck** the "Copy items if needed" option
![alt text](https://raw.githubusercontent.com/idomizrachi/Regen/master/Screenshots/Generated%20files.png "Generated Files")

Update your code:
1. Import the classes

`#import "Images.h"`

`#import "Strings.h"`

2. Update your code from:

`[UIImage imageNamed: @"login-button"]`

To:

`[UIImage imageNamed: Images.sharedInstance.loginButton]`

And from:

`NSLocalizedString(@"login.button", @"Login")`

To:

`Localization.loginButton`

## Credits\Thanks
https://github.com/icodeforlove/Colors for the ANSI color library

https://github.com/stencilproject/Stencil for the template engine

  https://github.com/kylef/PathKit - stencil dependency
  
  https://github.com/kylef/Spectre.git - stencil dependecy
  
