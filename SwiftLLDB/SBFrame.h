//
//  SBFrame.h
//  SwiftLLDB
//

#import "Enumerations.h"
#import <Foundation/Foundation.h>

@class SBAddress;
@class SBValueList;
@class SBSymbolContext;

NS_ASSUME_NONNULL_BEGIN

@interface SBFrame : NSObject

@property (readonly, nonatomic) BOOL isValid;
@property (readonly, nonatomic) NSInteger frameId;
@property (readonly, nonatomic) SBAddress *PCAddress;

- (SBSymbolContext *) symbolContextWithItems: (SymbolContextItem)items;

- (SBValueList *) variablesContainingArguments: (BOOL)arguments locals: (BOOL)locals statics: (BOOL)statics inScopeOnly: (BOOL)inScopeOnly;

@end

NS_ASSUME_NONNULL_END
