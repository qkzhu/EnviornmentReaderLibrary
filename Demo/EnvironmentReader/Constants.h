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
#define DATE_FORMAT_SERVER @"YYYY-MM-DD'T'HH:mm:ssZZZZZZ"
#define Date_FORMAT_DISPLAY @"DD/MM/YYYY HH:mm:ss a"

typedef enum {
    eViewTypeHome, eViewTypePSI, eViewTypePM25
} eViewType;

#endif /* Constants_h */
