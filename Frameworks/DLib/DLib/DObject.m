//
//  DObject.m
//  DLib
//
//  Created by apple on 2022/1/24.
//

#import "DObject.h"
#import "CLib/Test.h"

@implementation DObject

- (void)foo_d {
    NSLog(@"foo_d from D begain");
    [[Test new] foo];
    NSLog(@"foo_d from D end");
}

@end
