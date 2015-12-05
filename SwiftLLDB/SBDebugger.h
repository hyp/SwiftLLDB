//
//  SBDebugger.h
//  SwiftLLDB
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LanguageType) {
    Swift = 0x001e
};

@interface SBDebugger : NSObject
- (nonnull id) init;

- (void) setAsync: (BOOL)async;
- (BOOL) getAsync;

- (BOOL) setInputFileHandle: (nonnull NSFileHandle *)fileHandle error:(NSError **)error;
- (BOOL) setOutputFileHandle: (nonnull NSFileHandle *)fileHandle error:(NSError **)error;
- (BOOL) setErrorFileHanlde: (nonnull NSFileHandle *)fileHandle error:(NSError **)error;

- (void) runInterpreter: (BOOL)autoHandleEvents spawnThread:(BOOL)spawnThread;
- (BOOL) runRepl: (LanguageType)languageType options:(nonnull NSString *)replOptions error:(NSError **)error;

+ (void) setUp;
+ (void) tearDown;
@end

NS_ASSUME_NONNULL_END
