//
//  BObject.m
//  BLib
//
//  Created by apple on 2022/1/24.
//

#import "BObject.h"
#import "ALib/Test.h"
#import "ELib.h"

@implementation BObject

- (void)foo_b {
    NSLog(@"foo_b from B begain");
    [[Test new] foo];
    [[ELib new] foo_e];
    NSLog(@"foo_b from B end");
}

@end
