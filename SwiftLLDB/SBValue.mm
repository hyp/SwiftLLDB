//
//  SBValue.mm
//  SwiftLLDB
//

#import "SBValue.h"
#import "SBValue+Private.h"
#include "LLDB/LLDB.h"
#include "LLDB/SBThread.h"

@implementation SBDeclaration {
    lldb::SBDeclaration declaration;
}

- (void) setDeclaration: (void *)p {
    assert(p);
    declaration = *(lldb::SBDeclaration *)p;
}

- (BOOL) isValid {
    return declaration.IsValid();
}

- (NSInteger) line {
    return declaration.GetLine();
}

- (NSInteger) column {
    return declaration.GetColumn();
}

- (NSString *) filename {
    lldb::SBFileSpec fs = declaration.GetFileSpec();
    return fs.IsValid() ? [NSString stringWithUTF8String:fs.GetFilename()] : [NSString new];
}

@end

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
    // LLDB's typename can be nil.
    if (!str) {
        return @"";
    }
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

- (NSString *) value {
    const char *str = value.GetValue();
    return [NSString stringWithUTF8String:(str ? str : "")];
}

- (NSString *) objectDescription {
    const char *str = value.GetObjectDescription();
    return [NSString stringWithUTF8String:(str ? str : "")];
}

- (NSInteger) numChildren {
    return (NSInteger)value.GetNumChildren();
}

- (BOOL) isTypeFunctionType {
    return value.GetType().IsFunctionType();
}

- (BOOL) isTypeStructType {
    return value.GetType().GetTypeClass() == lldb::eTypeClassStruct;
}

- (BOOL) isTypeUnionType {
    return value.GetType().GetTypeClass() == lldb::eTypeClassUnion;
}

- (BOOL) isTypeClassType {
    return value.GetType().GetTypeClass() == lldb::eTypeClassClass;
}

- (SBDeclaration *) declaration {
    lldb::SBDeclaration llDecl = value.GetDeclaration();
    SBDeclaration *decl = [SBDeclaration new];
    decl.declaration = &llDecl;
    return decl;
}

- (int64_t) valueAsSigned {
    return value.GetValueAsSigned();
}

- (uint64_t) valueAsUnsigned {
    return value.GetValueAsUnsigned();
}

- (float) valueAsFloat {
    lldb::SBData data = value.GetData();
    lldb::SBError error;
    float result = data.GetFloat(error, 0);
    if (error.Success()) {
        return result;
    }
    return 0.0f;
}

- (double) valueAsDouble {
    lldb::SBData data = value.GetData();
    lldb::SBError error;
    float result = data.GetDouble(error, 0);
    if (error.Success()) {
        return result;
    }
    return 0.0;
}

- (SBValue *) childAtIndex: (NSInteger)idx {
    lldb::SBValue llValue = value.GetChildAtIndex((uint32_t)idx);
    SBValue *child = [SBValue new];
    child.value = &llValue;
    return child;
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
