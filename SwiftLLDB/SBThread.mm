//
//  SBTarget.mm
//  SwiftLLDB
//

#import "SBThread.h"
#import "SBThread+Private.h"
#import "SBFrame.h"
#import "SBFrame+Private.h"
#include "LLDB/LLDB.h"
#include "LLDB/SBThread.h"

@implementation SBThread {
    lldb::SBThread thread;
}

- (void) setThread: (void *)p {
    assert(p);
    thread = *(lldb::SBThread *)p;
}

- (BOOL) isValid {
    return thread.IsValid();
}

- (BOOL) isSuspended {
    return thread.IsSuspended();
}

- (BOOL) isStopped {
    return thread.IsStopped();
}

- (NSString *) name {
    return [NSString stringWithUTF8String: thread.GetName()];
}

- (StopReason) stopReason {
    switch (thread.GetStopReason()) {
        case lldb::eStopReasonInvalid: return StopReasonInvalid;
        case lldb::eStopReasonNone: return StopReasonNone;
        case lldb::eStopReasonTrace: return StopReasonTrace;
        case lldb::eStopReasonBreakpoint: return StopReasonBreakpoint;
        case lldb::eStopReasonWatchpoint: return StopReasonWatchpoint;
        case lldb::eStopReasonSignal: return StopReasonSignal;
        case lldb::eStopReasonException: return StopReasonException;
        case lldb::eStopReasonExec: return StopReasonExec;
        case lldb::eStopReasonPlanComplete: return StopReasonPlanComplete;
        case lldb::eStopReasonThreadExiting: return StopReasonThreadExiting;
        case lldb::eStopReasonInstrumentation: return StopReasonInstrumentation;
    }
}

- (NSInteger) stopReasonDataCount {
    return (NSInteger)thread.GetStopReasonDataCount();
}

- (uint64_t) stopReasonDataAtIndex: (NSInteger)idx {
    return thread.GetStopReasonDataAtIndex((uint32_t)idx);
}

- (NSInteger) numFrames {
    return (NSInteger)thread.GetNumFrames();
}

- (SBFrame *) selectedFrame {
    lldb::SBFrame llFrame = thread.GetSelectedFrame();
    SBFrame *frame = [SBFrame new];
    frame.frame = &llFrame;
    return frame;
}

- (SBFrame *) frameAtIndex: (NSInteger)idx {
    lldb::SBFrame llFrame = thread.GetFrameAtIndex((uint32_t)idx);
    SBFrame *frame = [SBFrame new];
    frame.frame = &llFrame;
    return frame;
}

@end

