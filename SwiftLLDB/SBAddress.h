//
//  SBAddress.h
//  SwiftLLDB
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBLineEntry : NSObject

@property (readonly, nonatomic) BOOL isValid;
@property (readonly, nonatomic) NSString *filename;
@property (readonly, nonatomic) NSInteger line;
@property (readonly, nonatomic) NSInteger column;

@end

@interface SBSymbolContext : NSObject

@property (readonly, nonatomic) BOOL isValid;
@property (readonly, nonatomic) SBLineEntry *lineEntry;

@end

@interface SBAddress : NSObject

@property (readonly, nonatomic) BOOL isValid;
@property (readonly, nonatomic) SBLineEntry *lineEntry;

@end

NS_ASSUME_NONNULL_END
