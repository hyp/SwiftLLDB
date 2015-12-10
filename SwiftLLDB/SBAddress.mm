//
//  SBAddress.mm
//  SwiftLLDB
//

#import "SBAddress.h"
#import "SBAddress+Private.h"
#include "LLDB/LLDB.h"
#include "LLDB/SBTarget.h"

// Mark - Line Entry

@implementation SBLineEntry {
    lldb::SBLineEntry lineEntry;
}

- (void) setLineEntry: (void *)p {
    assert(p);
    lineEntry = *(lldb::SBLineEntry *)p;
}

- (BOOL) isValid {
    return lineEntry.IsValid();
}

- (NSString *) filename {
    lldb::SBFileSpec fs = lineEntry.GetFileSpec();
    return [NSString stringWithUTF8String: fs.GetFilename()];
}

- (NSInteger) line {
    return (NSInteger)lineEntry.GetLine();
}

- (NSInteger) column {
    return (NSInteger)lineEntry.GetColumn();
}

@end

// Mark - Address

@implementation SBAddress {
    lldb::SBAddress address;
}

- (void) setAddress: (void *)p {
    assert(p);
    address = *(lldb::SBAddress *)p;
}

- (BOOL) isValid {
    return address.IsValid();
}

- (SBLineEntry *) lineEntry {
    lldb::SBLineEntry llEntry = address.GetLineEntry();
    SBLineEntry *entry = [SBLineEntry new];
    [entry setLineEntry:&llEntry];
    return entry;
}

@end

