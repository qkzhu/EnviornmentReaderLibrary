### REQ01
Library project (Utilities): EnvironmentReaderLibrary - It is an iOS framework project, with dependency of AFNetworking. It can deliver EnvironmentReaderLibrary.framework.

### REQ02
* Network API
  1 Send a `GET` request by passing URL String, additional parameters, the response will be executed in either `success` or `failure` callback block.
    ```objective-c
    - (void)GET:(nonnull NSString *)urlString
     parameters:(nullable id)parameters
        success:(nullable void (^)(id _Nullable responseObject))success
        failure:(nullable void (^)(NSError *error))failure;
    ```
    * Use API: 
        ```objective-c
        AFNetworkHandler *networkHandler = [AFNetworkHandler new];
        [networkHandler GET:@"https://data.gov.sg/dataset/psi" parameters:param success:^(id  _Nullable responseObject) {
          // success block with received objective
        } failure:^(NSError * _Nonnull error) {
          // failure block with error
        }];
        ```
* Local Data API:
  1 Save Data to local: 
    * data: any type object
    * pathString: A local path ULR in NSString
    ```objective-c
    - (BOOL)saveData:(nonnull id)data toPath:(nonnull NSString *)pathString;
    ```
    * Use API:
    ```objective-c
    PlistLocalDataHandler * dataHandler = [[PlistLocalDataHandler alloc] initWithPlistPath:@"/full/path/of/data.plist"];
    [self.localDataHandler saveData:@{@"name":@"west"} toPath:@"the/full/path/data.plist"];
    ```
  
  2 Retrieve Data from local:
    * pathString: A local path ULR in NSString
    ```objective-c
    - (nullable id)getDataFromPath:(nonnull NSString *)pathString;
    ```
    * Use API:
    ```objective-c
    PlistLocalDataHandler * dataHandler = [[PlistLocalDataHandler alloc] initWithPlistPath:@"/full/path/of/data.plist"];
    NSDictionary *data = [self.localDataHandler getDataFromPath:@"the/full/path/data.plist"];
    ```
    
### REQ03
Refer to EnvironmentReaderLibrary `Test` target.

### REQ04
The demo project uses one of the `PlistLocalDataHandler` which conforms `LocalDataInferface`, save the data do local in `.plist` format. 

### REQ05
In `Demo` project, fetching online data API is done by using `EnvironmentReaderLibrary`, implmented in `ERNetworkManager`:
  * Fetch data for particular date
    * queryDate: An NSDate object for query
    * success: block that will be executed when query is successful with received data in `NSDictionary`. 
    * failure: block that will be executed when query is failed with `NSError`.
  ```objective-c
  - (void)fetchEnviromentDataForDate:(nonnull NSDate *)queryDate
                           success:(nullable void (^)(id _Nullable responseObject))success
                           failure:(nullable void (^)(NSError *error))failure;
  ```

  * Fetch Latest Data: Fetch today's data. 
    * success: block that will be executed when query is successful with received data in `NSDictionary`. 
    * failure: block that will be executed when query is failed with `NSError`.
  ```objective-c
  - (void)fetchLatestEnviromentDataOnSuccess:(nullable void (^)(id _Nullable responseObject))success
                                     failure:(nullable void (^)(NSError *error))failure;
  ```

### REQ06
Refer to Demo/`EnvironmentReader` project.

### REQ07
In `Demo` project, fetching and saving local data API is done by using `EnvironmentReaderLibrary`, implemented in `ERDataManager`.
  * Save data to local: This function runs on `background thread`.
    * data: Any data that needs to be saved to local, but currently works only with `NSDictionary` data type.
    * complete: A callback block will be executed when the save process is done. The `BOOL` in the block indicate the result or saving process. `YES` means saving success, `NO` means saving failed
  ```objective-c
  - (void)saveData:(nonnull id)data onComplete:(nullable void (^)(BOOL))complete;
  ```
  
  * Get data from local: This function runs on `background thread`.
    * complete: A callback block will be executed when the retrieving and parsing process are done. The `id` in the block is the data retrieved and parsed from local.
  ```objective-c
  - (void)getDataOnComplete:(nullable void (^)(id))complete;
  ```
  
### REQ08
Refer to Demo/`EnvironmentReader` project. Suggest to test in a high latency network.

### REQ09
Refer to Demo/`EnvironmentReader` project. Suggest to test in a high latency network.

### REQ10
Refer to Demo/`EnvironmentReader` project.


### Previews:
| ![Image](https://github.com/qkzhu/EnviornmentReaderLibrary/blob/master/Demo/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%207%20-%202018-04-09%20at%2000.18.18.png) | ![Image](https://github.com/qkzhu/EnviornmentReaderLibrary/blob/master/Demo/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%207%20-%202018-04-09%20at%2000.18.23.png) | ![Image](https://github.com/qkzhu/EnviornmentReaderLibrary/blob/master/Demo/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%207%20-%202018-04-09%20at%2000.18.29.png) | ![Image](https://github.com/qkzhu/EnviornmentReaderLibrary/blob/master/Demo/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%207%20-%202018-04-09%20at%2000.19.11.png) |
| ------ | ------ | ------ | ------ |
