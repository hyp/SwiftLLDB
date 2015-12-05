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

@property (nonatomic, getter=isAsync) BOOL async;

- (BOOL) setInputFileHandle: (NSFileHandle *)fileHandle error:(NSError **)error;
- (BOOL) setOutputFileHandle: (NSFileHandle *)fileHandle error:(NSError **)error;
- (BOOL) setErrorFileHandle: (NSFileHandle *)fileHandle error:(NSError **)error;

- (void) runCommandInterpreter: (BOOL)autoHandleEvents spawnThread:(BOOL)spawnThread;
- (BOOL) runREPL: (LanguageType)languageType options:(NSString *)replOptions error:(NSError **)error;

+ (void) setUp;
+ (void) tearDown;
@end

NS_ASSUME_NONNULL_END
