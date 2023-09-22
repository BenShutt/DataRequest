# DataRequest

Modularization of data requests using Alamofire with concurrency.

## Usage

Define a decodable model served by HTTP response:

```swift
struct MyModel: Decodable { ... }
```

Specify the parameters of the endpoint of the request:

```swift
struct GetMyModel: JSONDataRequest {

    typealias ResponseBody = MyModel

    var urlComponents: URLComponents {
        ...
    }
}
```

Execute the request in an asynchronous environment:

```swift
let myModel = try await GetMyModel().request()
```

## Installation

Add to the `Package.swift`:

```swift
dependencies: [
    .package(
        url: "https://github.com/BenShutt/DataRequest.git",
        branch: "main"
    )
]
```

## Debug Logging

To log request and responses, make a new `Session` instance (managing its memory) with:

```swift
extension Session {

    static let api = Session(eventMonitors: [
        ResponseEventMonitor()
    ])
}
```

Then return it in the `session` property of the `DataRequest`.
This logs the the `debugDescription` of the `DataResponse`.
