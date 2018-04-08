//
//  Constants.h
//  EnvironmentReader
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define END_POINT_URL @"https://api.data.gov.sg/v1/environment/psi?date=2018-04-05"
#define PLIST_NAME @"EnviornmentReaderDB.plist"
#define DATE_FORMAT_SERVER @"yyyy-MM-dd'T'HH:mm:ssZZZZZ"
#define DATE_FORMAT_DISPLAY @"dd/MM/yyyy HH:mm:ss a"

typedef enum {
    eViewTypeHome = 100, eViewTypePSI, eViewTypePM25
} eViewType;

#endif /* Constants_h */
