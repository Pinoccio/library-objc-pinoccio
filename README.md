client-objc-pinoccio
====================

Objective C library for Pinoccio

How to
======
1. Download the zip [here](https://github.com/Pinoccio/library-objc-pinoccio/releases)
2. Drag the Pinoccio header and class file into your iOS project, Copy to project directory if needed, and add to your iOS app's target.
3. Add the header to whatever class you need to use the APi in.
```objc
#import "Pinoccio.h"
```

Functions, basic usage.
=========

Initializing library
```objc
PinoccioAPI *pinoccioAPI = [[PinoccioAPI alloc] init]; // this also initializes the keychain wrapper
```

Setting login email and password
```objc
[pinoccioAPI setPinoccioEmail:@"foo@bar.com"];
[pinoccioAPI setPinoccioPassword:@"foobizzle360noscope];

```
Logging in (changed API) This uses the set email and password stored in the keychain.
```objc
[pinoccioAPI loginWithCompletion:^(NSString *generatedToken, BOOL isOK) {
    if (isOK){
        token = generatedToken;
        isLoggedIn = YES;
    }else {
        NSLog(@"Username or password is incorrect!");
    }

}
```

Logging in. Required arguments: email, password (*Depredicated*)
```objc
NSString *token; // This and the bool can be a global variable that can be used anywhere in the class, the example demos this.
BOOL isLoggedIn;

pinoccioAPI loginWithCredentials:@"dylan@pinocc.io" password:@"Password2014" withCompletion:^(NSString *generatedToken, BOOL isOK) {
    if (isOK){
        token = generatedToken;
        isLoggedIn = YES;
    }else {
        NSLog(@"Username or password is incorrect!");
    }
}];
```

Logging out. Required arguments: token
```objc
[pinoccioAPI logoutWithToken:token withCompletion:^(BOOL isOK) {
    if (isOK) {
        [[[UIAlertView alloc] initWithTitle:@"Success!" message:@"You're logged out :D" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    }else {
        // Make sure you're logging out a token that is valid
    }
}];
```

Get array of troops for account.  Required arguments: token
```objc
[pinoccioAPI troopWithToken:token withCompletion:^(NSArray *troops, BOOL isOK) {
    if (isOK) {
        // Do something with troops
    }else {
        NSLog(@"Data is nil/null, check if user is logged in and token is valid.");
    }
}];
```

Get array of scouts in troop. Required arguments: TroopID, token
```objc
[pinoccioAPI scoutsWithTroopID:1 withToken:token withCompletion:^(NSArray *scoutArray, BOOL isOK) {
    if (isOK) {
        // Do something with scoutArray
    }else {
        NSLog(@"Data is nil/null, check if user is logged in and token is valid.");
    }
}];
```

Toggle led, pass bool true/false for led on/off. Required arguments: ScoutID, TroopID, token
```objc
[pinoccioAPI led:YES withScoutID:selectedScout withTroopID:selectedTroop withToken:token withCompletion:^(BOOL isOK) {
    if (isOK) {
        // If the function reaches here, the LED was toggled.
    }
}];
```

Send a bitlash command
```objc
[pinoccioAPI sendBitlash:@"print temperature.f" withScoutID:selectedScout withTroopID:selectedTroop withToken:token withCompletion:^(NSDictionary *returnedJSON, BOOL isOK) {
    if (isOK) {
        // Do something with returnedJSON, the reply is the object "reply"
        NSLog(@"%@",returnedJSON[@"reply"]);
    }
}];
```
