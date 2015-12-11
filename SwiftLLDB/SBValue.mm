//
//  SBValue.mm
//  SwiftLLDB
//

#import "SBValue.h"
#import "SBValue+Private.h"
#include "LLDB/LLDB.h"
#include "LLDB/SBThread.h"

@implementation SBValue {
    lldb::SBValue value;
}

- (void) setValue: (void *)p {
    assert(p);
    value = *(lldb::SBValue *)p;
}

- (BOOL) isValid {
    return value.IsValid();
}

- (uint64_t) valueId {
    return value.GetID();
}

- (NSString *) name {
    const char *str = value.GetName();
    assert(str);
    return [NSString stringWithUTF8String:str];
}

- (NSString *) typeName {
    const char *str = value.GetTypeName();
    assert(str);
    return [NSString stringWithUTF8String:str];
}

- (NSString *) displayTypeName {
    const char *str = value.GetDisplayTypeName();
    assert(str);
    return [NSString stringWithUTF8String:str];
}

- (NSUInteger) byteSize {
    return (NSUInteger)value.GetByteSize();
}

- (BOOL) isInScope {
    return value.IsInScope();
}

- (BOOL) isDynamic {
    return value.IsDynamic();
}

- (BOOL) isSynthetic {
    return value.IsSynthetic();
}

@end

@implementation SBValueList {
    lldb::SBValueList valueList;
}

- (void) setValueList: (void *)p {
    assert(p);
    valueList = *(lldb::SBValueList *)p;
}

- (BOOL) isValid {
    return valueList.IsValid();
}

- (NSInteger) count {
    return (NSInteger)valueList.GetSize();
}

- (SBValue *) valueAtIndex: (NSInteger)idx {
    lldb::SBValue llValue = valueList.GetValueAtIndex((uint32_t)idx);
    SBValue *value = [SBValue new];
    value.value = &llValue;
    return value;
}

- (SBValue *) firstValueByName: (NSString *)name {
    lldb::SBValue llValue = valueList.GetFirstValueByName([name UTF8String]);
    SBValue *value = [SBValue new];
    value.value = &llValue;
    return value;
}

@end
