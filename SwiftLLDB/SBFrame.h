//
//  SBFrame.h
//  SwiftLLDB
//

#import <Foundation/Foundation.h>

@class SBAddress;

NS_ASSUME_NONNULL_BEGIN

@interface SBFrame : NSObject

@property (readonly, nonatomic) BOOL isValid;
@property (readonly, nonatomic) NSInteger frameId;
@property (readonly, nonatomic) SBAddress *PCAddress;

@end

NS_ASSUME_NONNULL_END
