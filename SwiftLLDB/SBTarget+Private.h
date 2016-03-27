//
//  SBTarget+Private.h
//  SwiftLLDB
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBTarget()

- (void) setTarget: (void *)p;
- (lldb::SBTarget &) getTarget;

@end

NS_ASSUME_NONNULL_END
