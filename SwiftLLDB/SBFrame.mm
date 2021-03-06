//
//  SBFrame.mm
//  SwiftLLDB
//

#import "SBFrame.h"
#import "SBFrame+Private.h"
#import "SBAddress.h"
#import "SBValue.h"
#import "SBValue+Private.h"
#include "LLDB/LLDB.h"
#include "LLDB/SBFrame.h"
#include "LLDB/SBSymbolContext.h"
#import "SBAddress+Private.h"

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

- (SBSymbolContext *) symbolContextWithItems: (SymbolContextItem)items {
    uint32_t resolveScope = 0;
    if (items & SymbolContextItemTarget) {
        resolveScope |= lldb::eSymbolContextTarget;
    }
    if (items & SymbolContextItemModule) {
        resolveScope |= lldb::eSymbolContextModule;
    }
    if (items & SymbolContextItemCompilationUnit) {
        resolveScope |= lldb::eSymbolContextCompUnit;
    }
    if (items & SymbolContextItemFunction) {
        resolveScope |= lldb::eSymbolContextFunction;
    }
    if (items & SymbolContextItemBlock) {
        resolveScope |= lldb::eSymbolContextBlock;
    }
    if (items & SymbolContextItemLineEntry) {
        resolveScope |= lldb::eSymbolContextLineEntry;
    }
    if (items & SymbolContextItemSymbol) {
        resolveScope |= lldb::eSymbolContextSymbol;
    }
    lldb::SBSymbolContext llContext = frame.GetSymbolContext (resolveScope);
    SBSymbolContext *context = [SBSymbolContext new];
    context.symbolContext = &llContext;
    return context;
}

- (SBValueList *) variablesContainingArguments: (BOOL)arguments locals: (BOOL)locals statics: (BOOL)statics inScopeOnly: (BOOL)inScopeOnly {
    lldb::SBValueList llValues = frame.GetVariables(arguments, locals, statics, inScopeOnly);
    SBValueList *values = [SBValueList new];
    values.valueList = &llValues;
    return values;
}

@end

