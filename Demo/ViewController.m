//
//  ViewController.m
//  Demo
//
//  Created by Sam Meech-Ward on 2017-02-27.
//  Copyright © 2017 Sam Meech-Ward. All rights reserved.
//

#import "ViewController.h"
#import "NetworkManager.h"
#import "Planet.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doSomething:(UIButton *)sender {
    NetworkManager *networkManager = [[NetworkManager alloc] init];
    
    [networkManager getPlanets:^(NSArray *planets, NSError * _Nullable error) {
        
        for (Planet *planet in planets) {
            // Create a planet object
            NSLog(@"Name: %@", planet.name);
        }
    }];
}


@end
