//
//  Enumerations.h
//  SwiftLLDB
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, StateType) {
    StateTypeInvalid = 0,
    StateTypeUnloaded,     ///< Process is object is valid, but not currently loaded
    StateTypeConnected,    ///< Process is connected to remote debug services, but not launched or attached to anything yet
    StateTypeAttaching,    ///< Process is currently trying to attach
    StateTypeLaunching,    ///< Process is in the process of launching
    StateTypeStopped,      ///< Process or thread is stopped and can be examined.
    StateTypeRunning,      ///< Process or thread is running and can't be examined.
    StateTypeStepping,     ///< Process or thread is in the process of stepping and can not be examined.
    StateTypeCrashed,      ///< Process or thread has crashed and can be examined.
    StateTypeDetached,     ///< Process has been detached and can't be examined.
    StateTypeExited,       ///< Process has exited and can't be examined.
    StateTypeSuspended     ///< Process or thread is in a suspended state as far
};


typedef NS_ENUM(NSUInteger, StopReason) {
    StopReasonInvalid = 0,
    StopReasonNone,
    StopReasonTrace,
    StopReasonBreakpoint,
    StopReasonWatchpoint,
    StopReasonSignal,
    StopReasonException,
    StopReasonExec,        // Program was re-exec'ed
    StopReasonPlanComplete,
    StopReasonThreadExiting,
    StopReasonInstrumentation
};
