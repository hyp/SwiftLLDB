//
//  SBValue+Private.h
//  SwiftLLDB
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBDeclaration()

- (void) setDeclaration: (void *)p;

@end

@interface SBValue()

- (void) setValue: (void *)p;

@end

@interface SBValueList()

- (void) setValueList: (void *)p;

@end

NS_ASSUME_NONNULL_END
