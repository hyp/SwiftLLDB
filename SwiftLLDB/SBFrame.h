//
//  SBFrame.h
//  SwiftLLDB
//

#import <Foundation/Foundation.h>

@class SBAddress;
@class SBValueList;

NS_ASSUME_NONNULL_BEGIN

@interface SBFrame : NSObject

@property (readonly, nonatomic) BOOL isValid;
@property (readonly, nonatomic) NSInteger frameId;
@property (readonly, nonatomic) SBAddress *PCAddress;

- (SBValueList *) variablesContainingArguments: (BOOL)arguments locals: (BOOL)locals statics: (BOOL)statics inScopeOnly: (BOOL)inScopeOnly;

@end

NS_ASSUME_NONNULL_END
