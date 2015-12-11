//
//  SBFrame.mm
//  SwiftLLDB
//

#import "SBFrame.h"
#import "SBFrame+Private.h"
#import "SBAddress.h"
#import "SBAddress+Private.h"
#import "SBValue.h"
#import "SBValue+Private.h"
#include "LLDB/LLDB.h"
#include "LLDB/SBFrame.h"

@implementation SBFrame {
    lldb::SBFrame frame;
}

- (void) setFrame: (void *)p {
    assert(p);
    frame = *(lldb::SBFrame *)p;
}

- (BOOL) isValid {
    return frame.IsValid();
}

- (NSInteger) frameId {
    return (NSInteger)frame.GetFrameID();
}

- (SBAddress *) PCAddress {
    lldb::SBAddress llAddress = frame.GetPCAddress();
    SBAddress *address = [SBAddress new];
    address.address = &llAddress;
    return address;
}

- (SBValueList *) variablesContainingArguments: (BOOL)arguments locals: (BOOL)locals statics: (BOOL)statics inScopeOnly: (BOOL)inScopeOnly {
    lldb::SBValueList llValues = frame.GetVariables(arguments, locals, statics, inScopeOnly);
    SBValueList *values = [SBValueList new];
    values.valueList = &llValues;
    return values;
}

@end

