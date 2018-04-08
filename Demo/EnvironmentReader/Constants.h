//
//  Constants.h
//  EnvironmentReader
//
//  Created by QianKun on 7/4/18.
//  Copyright © 2018 QianKun. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define END_POINT_URL @"https://api.data.gov.sg/v1/environment/psi"
#define PLIST_NAME @"EnviornmentReaderDB.plist"
#define DATE_FORMAT_SERVER @"yyyy-MM-dd'T'HH:mm:ssZZZZZ"
#define DATE_FORMAT_DISPLAY @"dd/MM/yyyy HH:mm:ss a"
#define DATE_FORMAT_QUERY @"yyyy-MM-dd"

typedef enum {
    eViewTypeHome = 100, eViewTypePSI, eViewTypePM25, eViewTypeMap
} eViewType;

#endif /* Constants_h */
