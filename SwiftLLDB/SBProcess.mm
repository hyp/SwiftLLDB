//
//  SBProcess.mm
//  SwiftLLDB
//

#import "SBProcess.h"
#import "SBProcess+Private.h"
#import "SBThread.h"
#import "SBThread+Private.h"
#include "LLDB/LLDB.h"
#include "LLDB/SBTarget.h"

@implementation SBProcess {
    lldb::SBProcess process;
}

- (void) setProcess: (void *)p {
    assert(p);
    process = *(lldb::SBProcess *)p;
}

- (BOOL) isValid {
    return process.IsValid();
}

- (StateType) state {
    return (StateType)process.GetState();
}

- (NSInteger) numThreads {
    return (NSInteger)process.GetNumThreads();
}

- (SBThread *) selectedThread {
    lldb::SBThread llThread = process.GetSelectedThread();
    SBThread *thread = [SBThread new];
    thread.thread = &llThread;
    return thread;
}

- (SBThread *) threadAtIndex: (NSInteger)idx {
    lldb::SBThread llThread = process.GetThreadAtIndex((size_t)idx);
    SBThread *thread = [SBThread new];
    thread.thread = &llThread;
    return thread;
}

- (BOOL) destroy: (NSError **)error {
    lldb::SBError llError = process.Destroy();
    if (llError.Success()) {
        return YES;
    }
    if (error) {
        const char *errorString = llError.GetCString();
        NSString *description = [NSString stringWithUTF8String:(errorString ? errorString : "")];
        *error = [NSError errorWithDomain:NSPOSIXErrorDomain
                                     code:llError.GetError()
                                 userInfo:@{ NSLocalizedDescriptionKey: description }];
    }
    return NO;
}

- (void) sendAsyncInterrupt {
    process.SendAsyncInterrupt();
}

@end

