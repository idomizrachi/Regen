# Regen
Regen generates objective-c code for accessing your images and localized string. 

## Installation

After cloning\download the project, run:

`xcodebuild install` 

And `regen` will install to `/usr/local/bin`

## Usage

So instead of: 

`[UIImage imageNamed: @"login-button"]`

Use:

`[UIImage imageNamed: Images.loginButton]`

And instead of:

`NSLocalizedString(@"login.button", @"Login")`

Use:

`[Localization loginButton]`


The generated class name is configurable from command line.


## Thanks
https://github.com/icodeforlove/Colors for the ANSI color library
