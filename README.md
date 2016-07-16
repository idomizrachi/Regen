# Regen
Regen generates objective-c code for accessing your images and localized string. 

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
