//
//  URLRequestMaker.swift
//  DataRequest
//
//  Created by Ben Shutt on 23/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import Alamofire

/// An entity which builds a `URLRequest`.
/// If the entity (also) conforms to `RequestBody` then the HTTP body and content type header is set.
public protocol URLRequestMaker: URLRequestConvertible {

    /// The components of a URL.
    var urlComponents: URLComponents { get }

    /// The HTTP method.
    /// Defaults to `.get`.
    var method: HTTPMethod { get }

    /// Additional headers to append to the default.
    /// Defaults to empty.
    var additionalHeaders: HTTPHeaders { get }
}

// MARK: - Extensions

public extension URLRequestMaker {

    /// Defaults to `.get`
    var method: HTTPMethod {
        .get
    }

    /// Defaults to empty
    var additionalHeaders: HTTPHeaders {
        []
    }

    /// Get all HTTP headers
    var headers: HTTPHeaders {
        var headers: HTTPHeaders = .default
        if let requestBody = self as? RequestBody {
            headers.append(requestBody.contentType)
        }
        headers.append(additionalHeaders)
        return headers
    }

    /// Make the URL request
    var urlRequest: URLRequest {
        get throws {
            var request = try URLRequest(
                url: urlComponents,
                method: method,
                headers: headers
            )
            if let requestBody = self as? RequestBody {
                request.httpBody = try requestBody.body
            }
            return request
        }
    }

    func asURLRequest() throws -> URLRequest {
        try urlRequest
    }
}
