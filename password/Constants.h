//
//  Constants.h
//  password
//
//  Created by Alexander Gomzyakov on 24.03.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#ifndef password_Constants_h
#define password_Constants_h


/**
 Используется для сохранения пин-кода в NSUserDefaults.
 Также является уникальным идентификатором для хранилища Keychain.
 */
#define PIN_SAVED @"hasSavedPIN"

// Used for saving the user's name to NSUserDefaults.
#define USERNAME @"username"

// Used to specify the application used in accessing the Keychain.
#define APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]

// Used to help secure the PIN.
// Ideally, this is randomly generated, but to avoid the unnecessary complexity and overhead of storing the Salt separately, we will standardize on this key.
// !!KEEP IT A SECRET!!
#define SALT_HASH @"FvTivqTqZXsgLLx4v3P8TGRyVNaSOB1pvfm02wvGadj7SLHV8GrfxaZ84oGA8RsKdNRpxdAojXYg9iAj"

// Typedefs just to make it a little easier to read in code.
typedef enum {
    kAlertTypePIN = 0,
    kAlertTypeSetup
} AlertTypes;

typedef enum {
    kTextFieldPIN = 1,
    kTextFieldName,
    kTextFieldPassword
} TextFieldTypes;


#endif
