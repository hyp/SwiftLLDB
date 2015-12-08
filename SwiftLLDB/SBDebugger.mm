//
//  SBDebugger.mm
//  SwiftLLDB
//

#import "SBDebugger.h"
#include "LLDB/LLDB.h"
#include "LLDB/SBDebugger.h"
#include <stdio.h>

@implementation SBDebugger {
    lldb::SBDebugger debugger;
}

- (nonnull id)init {
    self = [super init];
    if (self) {
        self->debugger = lldb::SBDebugger::Create();
    }
    return self;
}

- (void) setAsync: (BOOL)async {
    debugger.SetAsync(async);
}

- (BOOL) isAsync {
    return debugger.GetAsync();
}

/// A helper method that returns a pointer to a C FILE for that file handle.
FILE *openFileHanle(NSFileHandle *fileHandle, const char *mode, NSError **error) {
    FILE *inputFile = fdopen([fileHandle fileDescriptor], mode);
    if (!inputFile) {
        if (error) {
            *error = [NSError errorWithDomain:NSPOSIXErrorDomain
                                         code:errno
                                     userInfo:@{ NSLocalizedDescriptionKey: @"Failed to open the file descriptor" }];
        }
        return NULL;
    }
    return inputFile;
}

- (BOOL) setInputFileHandle: (nonnull NSFileHandle *)fileHandle error:(NSError **)error {
    FILE *f = openFileHanle(fileHandle, "r", error);
    if (!f) { return NO; }
    debugger.SetInputFileHandle(f, /*transfer_ownership=*/true);
    return YES;
}

- (BOOL) setOutputFileHandle: (nonnull NSFileHandle *)fileHandle error:(NSError **)error {
    FILE *f = openFileHanle(fileHandle, "w", error);
    if (!f) { return NO; }
    debugger.SetOutputFileHandle(f, /*transfer_ownership=*/true);
    return YES;
}

- (BOOL) setErrorFileHandle: (nonnull NSFileHandle *)fileHandle error:(NSError **)error {
    FILE *f = openFileHanle(fileHandle, "w", error);
    if (!f) { return NO; }
    debugger.SetErrorFileHandle(f, /*transfer_ownership=*/true);
    return YES;
}

- (void) runCommandInterpreter: (BOOL)autoHandleEvents spawnThread:(BOOL)spawnThread {
    debugger.RunCommandInterpreter(autoHandleEvents, spawnThread);
}

- (BOOL) runREPL: (LanguageType)languageType options:(nonnull NSString *)replOptions error:(NSError **)error {
    if (error)
        *error = NULL;
    const char *options = [replOptions UTF8String];
    lldb::SBError llerror (debugger.RunREPL(lldb::LanguageType(languageType), options));
    if (llerror.Fail() && error) {
        const char *errorString = llerror.GetCString();
        NSString *description = [NSString stringWithUTF8String:(errorString ? errorString : "")];
        *error = [NSError errorWithDomain:NSPOSIXErrorDomain
                                     code:llerror.GetError()
                                 userInfo:@{ NSLocalizedDescriptionKey: description }];
        return NO;
    }
    return YES;
}

+ (void) setUp {
    lldb::SBDebugger::Initialize();
}

+ (void) tearDown {
    lldb::SBDebugger::Terminate();
}

@end
