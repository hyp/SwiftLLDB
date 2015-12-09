//
//  SBDebugger.h
//  SwiftLLDB
//

#import <Foundation/Foundation.h>

@class SBTarget;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LanguageType) {
    Swift = 0x001e
};

@interface SBDebugger : NSObject

@property (nonatomic, getter=isAsync) BOOL async;

- (BOOL) setInputFileHandle: (NSFileHandle *)fileHandle error:(NSError **)error;
- (BOOL) setOutputFileHandle: (NSFileHandle *)fileHandle error:(NSError **)error;
- (BOOL) setErrorFileHandle: (NSFileHandle *)fileHandle error:(NSError **)error;

@property (readonly, nonatomic, getter=getNumTargets) NSInteger numTargets;
@property (readonly, nonatomic, getter=getSelectedTarget) SBTarget *selectedTarget;
- (SBTarget *) getTargetAtIndex: (NSInteger)index;

- (void) clear;
- (void) handleCommand: (NSString *)command;
- (void) runCommandInterpreter: (BOOL)autoHandleEvents spawnThread:(BOOL)spawnThread;
- (BOOL) runREPL: (LanguageType)languageType options:(NSString *)replOptions error:(NSError **)error;

+ (void) setUp;
+ (void) tearDown;
@end

NS_ASSUME_NONNULL_END
