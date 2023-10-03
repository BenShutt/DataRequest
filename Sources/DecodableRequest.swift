//
//  DecodableRequest.swift
//  DataRequest
//
//  Created by Ben Shutt on 23/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import Alamofire

/// An endpoint that executes a URL request and decodes the response into a model.
public protocol DecodableRequest: URLRequestMaker {

    /// Model expected in the response body that will be decoded from data.
    /// - Note: `Empty` can be used when a response is empty. E.g. on HTTP status code 204.
    associatedtype ResponseBody: Decodable

    /// The Alamofire session.
    /// Defaults to `.default`.
    var session: Session { get }

    /// Define how the response data should be decoded.
    /// Defaults to `JSONDecoder()`.
    var decoder: DataDecoder { get }

    /// The request interceptor.
    /// Defaults to `nil`.
    var interceptor: RequestInterceptor? { get }

    /// Validate the response.
    /// Defaults to `true`.
    var validate: Bool { get }

    /// Configure the request before executing.
    /// Defaults to returning the argument without mutating.
    /// - Parameter urlRequest: The URL request
    func configuring(urlRequest: URLRequest) -> URLRequest
}

// MARK: - Extensions

public extension DecodableRequest {

    /// Defaults to `.default`
    var session: Session {
        .default
    }

    /// Defaults to `JSONDecoder()`
    var decoder: DataDecoder {
        JSONDecoder()
    }

    /// Defaults to `nil`
    var interceptor: RequestInterceptor? {
        nil
    }

    /// Defaults to `true`
    var validate: Bool {
        true
    }

    /// Defaults to returning the argument without mutating
    func configuring(urlRequest: URLRequest) -> URLRequest {
        urlRequest
    }

    // MARK: URLRequestMaker

    /// Defaults to `[.acceptJSON]`
    var additionalHeaders: HTTPHeaders {
        [.acceptJSON]
    }

    // MARK: Request

    /// Execute the data request decoding the response
    /// - Returns: The response body
    @discardableResult
    func request() async throws -> ResponseBody {
        try await session.request(
            configuring(urlRequest: urlRequest),
            interceptor: interceptor
        )
        .decodeValue(
            ResponseBody.self,
            validate: validate,
            decoder: decoder
        )
    }
}
