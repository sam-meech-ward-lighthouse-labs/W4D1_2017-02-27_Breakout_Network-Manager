//
//  NetworkManager.h
//  Demo
//
//  Created by Sam Meech-Ward on 2017-02-27.
//  Copyright © 2017 Sam Meech-Ward. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

- (void)getPlanets:(void (^)(NSArray *planets, NSError *error))blockName;

@end
