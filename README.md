# DataRequest

Modularization of data requests using Alamofire with concurrency.

## Usage

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

## Motivation

This package encourages a design pattern where the configuration of an endpoint is encapsulated into the properties of a structure, similarly to a SwiftUI `View`.
There is also some helpful shorthand.

It adds rather than replaces; direct use of Alamofire (or vanilla `URLSession`) is still encouraged.

## Notes

* The `URLRequestMaker` checks for conformance of `RequestBody` and adds the HTTP body accordingly.
* A `DecodableRequest` is a `URLRequestMaker` with the configuration properties of a data request defaulted.

## Uploads

Since `URLRequestMaker` conforms to `URLRequestConvertible` you can use Alamofire directly:

```swift
AF.upload(data, with: Endpoint())
    .uploadProgress { progress in ... }
    .decodeValue()
```

where `Endpoint` is some `URLRequestMaker` since it conforms to `URLRequestConvertible`.

## Debug Logging

To log request/responses, make a new `Session` instance (managing its lifecycle accoringly) with a `ResponseEventMonitor` event monitor.
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
