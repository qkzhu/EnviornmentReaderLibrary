//
//  LocalDataInterface.h
//  EnvironmentReaderLibrary
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef LocalDataInterface_h
#define LocalDataInterface_h

NS_ASSUME_NONNULL_BEGIN

@protocol LocalDataInterface <NSObject>

- (BOOL)saveData:(nonnull id)data toPath:(nonnull NSString *)pathString;

- (nullable id)getDataFromPath:(nonnull NSString *)pathString;

@end

NS_ASSUME_NONNULL_END

#endif /* LocalDataInterface_h */
