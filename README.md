# Regen
Regen generates objective-c code for accessing your images and localized string.

## What's New
### 0.0.6
Improve generated property names

Added new parameter to remove console color

Run localization operation only on the english strings file to save time

Update color codes

### 0.0.5
Added swift generated files

Print additional information during the execution using "-v" or "--verbose"

## Installation

After cloning\download the project, run:

`xcodebuild install`

And `regen` will install to `/usr/local/bin`

Alternativly you can use brew:

`brew install https://raw.githubusercontent.com/idomizrachi/Regen/master/formula/regen.rb`

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

`[UIImage imageNamed: Images.loginButton]`

And from:

`NSLocalizedString(@"login.button", @"Login")`

To:

`Localization.loginButton`

## Credits\Thanks
https://github.com/icodeforlove/Colors for the ANSI color library
