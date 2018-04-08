#### This document describe the design for the library (Utilities) `EnvironmentReaderLibrary`

From the library to the Demo project together, there are 3 layers:
  1. Interface Layer (Library project): This layer defines protocols for Network and Local Data.
      * Network: `NetworkInterface.h`
      * Local Data: `LocalDataInterface.h`
  2. Implmentation Layer (Library project): This layer create class that conform those interfaces that defined in `Interface Layer`
      * For testing purpose (dependency injection): The implmentation use hard code data only. By using these class, development can start without waiting for the real implmentation compelte. 
        1. Network: `MockNetworkHandler`
        2. Local Data: `MockLocalDataHandler`
      
      * For development purpose: The real implmentation.
        1. Network: `AFNetworkHandler`, the real implmentation is with the power AFNetworking library.
        2. Local Data: `PlistLocalDataHandler`, keep data into plist locally and read from the plist.
  3. Project Integrate Layer (Demo project): The real App project created its own class for handling Network and Local data task, with the power of Library project:
      * Network: `ERNetworkManager`, it hanldes network call to NEA's web API.
      * Local Data: `ERDataManager`, it handles local data read/write to plist, with its own file path and logic.
      
With this design, developer can replace the implmentation of second layer or even third layer without breaking any code, as long as the first layer protocols don't change.

By placing mocking implmentations on second layer, I can start to develop the App even neigher Network and Local Data handler is not ready. 
