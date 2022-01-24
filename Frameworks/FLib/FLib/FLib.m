//
//  FLib.m
//  FLib
//
//  Created by apple on 2022/1/24.
//

#import "FLib.h"
#import "ELib.h"

@implementation FLib

- (void)foo_f {
    NSLog(@"foo_f from F begain");
    [[ELib new] foo_e];
    NSLog(@"foo_f from F end");
}

@end
