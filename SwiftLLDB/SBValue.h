//
//  SBValue.h
//  SwiftLLDB
//

#import "Enumerations.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBValue : NSObject

@property (readonly, nonatomic) BOOL isValid;
@property (readonly, nonatomic) uint64_t valueId;
@property (readonly, nonatomic) NSString *name;
@property (readonly, nonatomic) NSString *typeName;
@property (readonly, nonatomic) NSString *displayTypeName;
@property (readonly, nonatomic) NSUInteger byteSize;
@property (readonly, nonatomic) BOOL isInScope;
@property (readonly, nonatomic) BOOL isDynamic;
@property (readonly, nonatomic) BOOL isSynthetic;
@property (readonly, nonatomic) NSString *value;

- (int64_t) valueAsSigned;
- (uint64_t) valueAsUnsigned;
- (float) valueAsFloat;
- (double) valueAsDouble;

@end

@interface SBValueList : NSObject

@property (readonly, nonatomic) BOOL isValid;
@property (readonly, nonatomic) NSInteger count;
- (SBValue *) valueAtIndex: (NSInteger)idx;
- (SBValue *) firstValueByName: (NSString *)name;

@end

NS_ASSUME_NONNULL_END
