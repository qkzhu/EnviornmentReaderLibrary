//
//  ERMapAnnotation.h
//  EnvironmentReader
//
//  Created by QianKun on 8/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ERMapAnnotation : NSObject <MKAnnotation>

- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subTitle latitude:(double)latitudeVal longitude:(double)longitudeVal;

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subtitle;

@end

NS_ASSUME_NONNULL_END
