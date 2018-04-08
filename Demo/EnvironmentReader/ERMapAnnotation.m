//
//  ERMapAnnotation.m
//  EnvironmentReader
//
//  Created by QianKun on 8/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import "ERMapAnnotation.h"

@interface ERMapAnnotation()


@end

@implementation ERMapAnnotation

- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subTitle latitude:(double)latitudeVal longitude:(double)longitudeVal
{
    if (self = [super init])
    {
        self.title = title;
        self.subtitle = subTitle;
        self.coordinate = CLLocationCoordinate2DMake(latitudeVal, longitudeVal);
    }
    
    return self;
}

@end
