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

    /// Append a `header`
    /// - Parameter header: `HTTPHeader`
    mutating func append(_ header: HTTPHeader) {
        self = appending(header)
    }

    /// Append `headers`
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

    /// Append `headers` and return new `HTTPHeaders`
    /// - Parameter headers: `HTTPHeaders`
    /// - Returns: `HTTPHeaders`
    func appending(_ headers: HTTPHeaders) -> HTTPHeaders {
        var allHeaders = self
        headers.forEach { allHeaders.add($0) }
        return allHeaders
    }
}
