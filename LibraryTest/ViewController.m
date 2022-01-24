//
//  ViewController.m
//  LibraryTest
//
//  Created by apple on 2022/1/21.
//

#import "ViewController.h"
#import "BLib/BObject.h"
//#import "DLib/DObject.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[BObject new] foo_b];
//    [[DObject new] foo_d];
}


@end
