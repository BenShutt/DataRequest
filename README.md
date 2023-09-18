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
