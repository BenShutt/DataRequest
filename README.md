# DataRequest

Modularization of data requests using Alamofire with concurrency.

This package encourages a design pattern where the _description_ of an endpoint is encapsulated into the properties of a structure.
A similar design to a SwiftUI `View`.
It adds rather than replaces; direct use of Alamofire (or `URLSession`) is still encouraged.
There is also some helpful shorthand.

## Example Usage

Define a decodable model returned in a response:

```swift
struct Model: Decodable { ... }
```

Specify the configuration of the request endpoint:

```swift
struct GetModel: DecodableRequest {
    typealias ResponseBody = Model

    var urlComponents: URLComponents {
        ...
    }
}
```

Finally, execute the request in an asynchronous environment:

```swift
let model = try await GetModel().request()
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

## Uploads

A `DecodableRequest` is a `URLRequestMaker` with the configuration properties of a data request defaulted.
Since `URLRequestMaker` conforms to `URLRequestConvertible` you can use Alamofire directly:

```swift
AF.upload(data, with: Endpoint())
    .uploadProgress { progress in ... }
    .decodeValue()
```

where `Endpoint` is some `URLRequestMaker`.

## Debug Logging

To log request/responses, make a new `Session` instance (managing its lifecycle accordingly) with a `ResponseEventMonitor` event monitor.
The `ResponseEventMonitor` logs the `debugDescription` of the `DataResponse`.
For example:

```swift
extension Session {
    static let debug = Session(eventMonitors: [
        ResponseEventMonitor()
    ])
}
```

This can be returned in the `session` property of the `DecodableRequest`.
