client-objc-pinoccio
====================

Objective C library for Pinoccio

How to
======
1. Download the zip [here](https://github.com/Pinoccio/library-objc-pinoccio/releases)
2. Drag the Pinoccio header and class file into your iOS project, Copy to project directory if needed, and add to your iOS app's target.
3. Add the header to whatever class you need to use the APi in.
```objc
import "Pinoccio.h"
```

Functions, basic usage.
=========

Initializing library
```objc
PinoccioAPI *pinoccioAPI = [[PinoccioAPI alloc] init];
```

Logging in. 
```objc
pinoccioAPI loginWithCredentials:@"dylan@pinocc.io" password:@"Password2014" withCompletion:^(NSString *generatedToken, BOOL isOK) {
if (isOK){
token = generatedToken;
isLoggedIn = YES;

}else {
NSLog(@"Username and password is incorrect!");
}
}];
```
