//
//  HTTPHeaders+Extensions.swift
//  DataRequest
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import Alamofire

public extension HTTPHeaders {

    /// Append `headers` to this instance
    /// - Parameter headers: `HTTPHeader`
    mutating func append(_ headers: HTTPHeader...) {
        append(HTTPHeaders(headers))
    }

    /// Append `headers` to this instance
    /// - Parameter headers: `HTTPHeaders`
    mutating func append(_ headers: HTTPHeaders) {
        self = appending(headers)
    }

    /// Append `headers` and return new `HTTPHeaders`
    /// - Parameter headers: The headers
    /// - Returns: `HTTPHeaders`
    func appending(_ headers: HTTPHeader...) -> HTTPHeaders {
        appending(HTTPHeaders(headers))
    }

    /// Append `headers` and return a new `HTTPHeaders` instance
    /// - Parameter headers: `HTTPHeaders`
    /// - Returns: `HTTPHeaders`
    func appending(_ headers: HTTPHeaders) -> HTTPHeaders {
        var allHeaders = self
        headers.forEach { allHeaders.add($0) }
        return allHeaders
    }
}
