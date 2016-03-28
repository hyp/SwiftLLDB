//
//  SBAddress+Private.h
//  SwiftLLDB
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBSymbolContext()

- (void) setSymbolContext: (lldb::SBSymbolContext *)p;

@end

@interface SBAddress()

- (void) setAddress: (void *)p;

@end

NS_ASSUME_NONNULL_END
