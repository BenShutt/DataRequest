//
//  URLRequestMaker.swift
//  DataRequest
//
//  Created by Ben Shutt on 23/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import Alamofire

/// An entity that builds a `URLRequest`.
public protocol URLRequestMaker: URLRequestConvertible {

    /// The components of a URL.
    var urlComponents: URLComponents { get }

    /// The HTTP method.
    ///
    /// Defaults to `.get`.
    var method: HTTPMethod { get }

    /// The default HTTP headers.
    ///
    /// Defaults to `.default` (from Alamofire).
    ///
    /// - Note: The final `URLRequest` should be considered the source of truth.
    /// For example, the content type might be added while making the `URLRequest`
    /// but may not be defined here.
    var headers: HTTPHeaders { get }

    /// The HTTP body.
    ///
    /// Defaults to `nil`.
    var body: HTTPBody? { get throws }

    /// The `URLRequest` constructed from the other properties, before updates.
    var urlRequest: URLRequest { get throws }

    // MARK: URLRequestConvertible

    /// Apply updates to the `urlRequest` before returning.
    /// For example, applying `URLEncoding`.
    ///
    /// By default, returns `urlRequest`.
    /// Conformers may provide their own implementation mutating `urlRequest`.
    func asURLRequest() throws -> URLRequest
}

// MARK: - Defaults

public extension URLRequestMaker {
    var method: HTTPMethod {
        .get
    }

    var headers: HTTPHeaders {
        .default
    }

    var body: HTTPBody? {
        nil
    }

    var urlRequest: URLRequest {
        get throws {
            let body = try body

            var headers = headers
            if let contentType = body?.contentType {
                headers.append(contentType)
            }

            var request = try URLRequest(
                url: urlComponents,
                method: method,
                headers: headers
            )
            request.httpBody = body?.body
            return request
        }
    }
}

// MARK: - URLRequestConvertible

public extension URLRequestMaker {
    func asURLRequest() throws -> URLRequest {
        try urlRequest
    }
}
