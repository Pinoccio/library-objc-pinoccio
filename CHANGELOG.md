Changes 8/27/14 Version: 1.0-2
==============================
Added;
    function 
        ```objc
            [pinoccioAPI setPinoccioEmail:@"foo@bar.com"];

            [pinoccioAPI setPinoccioPassword:@"foobizzle360noscope];

            [pinoccioAPI loginWithCompletion:^(NSString *generatedToken, BOOL isOK) {
                if (isOK){
                    token = generatedToken;
                    isLoggedIn = YES;
                }else {
                    NSLog(@"Username or password is incorrect!");
                }
            }
        ```
Depredicated but still implemented;
```objc
    pinoccioAPI loginWithCredentials:@"dylan@pinocc.io" password:@"Password2014" withCompletion:^(NSString *generatedToken, BOOL isOK) {
        if (isOK){
            token = generatedToken;
            isLoggedIn = YES;
        }else {
            NSLog(@"Username or password is incorrect!");
        }
    }];
```