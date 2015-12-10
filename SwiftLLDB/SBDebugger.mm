//
//  SBDebugger.mm
//  SwiftLLDB
//

#import "SBDebugger.h"
#import "SBTarget.h"
#import "SBTarget+Private.h"
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

- (BOOL) isValid {
    return debugger.IsValid();
}

/// A helper method that returns a pointer to a C FILE for that file handle.
FILE *openFileHandle(NSFileHandle *fileHandle, const char *mode, NSError **error) {
    FILE *inputFile = fdopen([fileHandle fileDescriptor], mode);
    if (!inputFile) {
        if (error) {
            *error = [NSError errorWithDomain:NSPOSIXErrorDomain
                                         code:errno
                                     userInfo:@{ NSLocalizedDescriptionKey: @"Failed to open the file descriptor" }];
        }
        return NULL;
    }
    setbuf(inputFile, NULL);
    return inputFile;
}

- (BOOL) setInputFileHandle: (nonnull NSFileHandle *)fileHandle error:(NSError **)error {
    FILE *f = openFileHandle(fileHandle, "r", error);
    if (!f) { return NO; }
    debugger.SetInputFileHandle(f, /*transfer_ownership=*/false);
    return YES;
}

- (BOOL) setOutputFileHandle: (nonnull NSFileHandle *)fileHandle error:(NSError **)error {
    FILE *f = openFileHandle(fileHandle, "w", error);
    if (!f) { return NO; }
    debugger.SetOutputFileHandle(f, /*transfer_ownership=*/false);
    return YES;
}

- (BOOL) setErrorFileHandle: (nonnull NSFileHandle *)fileHandle error:(NSError **)error {
    FILE *f = openFileHandle(fileHandle, "w", error);
    if (!f) { return NO; }
    debugger.SetErrorFileHandle(f, /*transfer_ownership=*/false);
    return YES;
}

- (NSInteger) getNumTargets {
    return (NSInteger)debugger.GetNumTargets();
}

- (SBTarget *) getSelectedTarget {
    SBTarget *target = [[SBTarget alloc] init];
    lldb::SBTarget llTarget = debugger.GetSelectedTarget();
    [target setTarget: &llTarget];
    return target;
}

- (SBTarget *) targetAtIndex: (NSInteger)index {
    SBTarget *target = [[SBTarget alloc] init];
    lldb::SBTarget llTarget  = debugger.GetTargetAtIndex((uint32_t)index);
    [target setTarget: &llTarget];
    return target;
}

- (void) clear {
    debugger.Clear();
}

- (void) handleCommand: (NSString *)command {
    debugger.HandleCommand([command UTF8String]);
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
