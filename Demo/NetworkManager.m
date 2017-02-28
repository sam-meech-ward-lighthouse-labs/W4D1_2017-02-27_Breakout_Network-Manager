//
//  NetworkManager.m
//  Demo
//
//  Created by Sam Meech-Ward on 2017-02-27.
//  Copyright © 2017 Sam Meech-Ward. All rights reserved.
//

#import "NetworkManager.h"
#import "Planet.h"

@implementation NetworkManager

- (void)getPlanets:(void (^)(NSArray *planets, NSError *error))completionHandler {
    
    NSURL *url = [NSURL URLWithString:@"https://swapi.co/api/planets/"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    
    [self executeURLRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            // Handle error
            NSLog(@"%@", error.localizedDescription);
            completionHandler(nil, error);
            return;
        }
        
        NSArray *planets = [self handlePlanetData:data error:&error];
        if (error) {
            // Handle error
            completionHandler(nil, error);
            return;
        }
        
        completionHandler(planets, nil);
    }];
}

- (void)executeURLRequest:(NSURLRequest *)request completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:completionHandler];
    
    [dataTask resume];
}

- (NSArray *)handlePlanetData:(NSData *)data error:(NSError **)error {
    
    // Success
    NSError *jsonError;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    
    if (jsonError) {
        // Handle error
        *error = jsonError;
        return nil;
    }
    
    NSArray<Planet *> *planets = [self planetsFromJSON:json[@"results"]];
    return planets;
}

- (NSArray<Planet *> *)planetsFromJSON:(NSArray<NSDictionary *> *)jsonPlanets {
    
    NSMutableArray *planets = [NSMutableArray arrayWithCapacity:jsonPlanets.count];
    for (NSDictionary *json in jsonPlanets) {
        Planet *planet = [self planetFromJSON:json];
        [planets addObject:planet];
    }
    
    return [planets copy];
}

- (Planet *)planetFromJSON:(NSDictionary *)json {
    Planet *planet = [[Planet alloc] init];
    planet.name = json[@"name"];
    return planet;
}

@end
