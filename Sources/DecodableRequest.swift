//
//  DecodableRequest.swift
//  DataRequest
//
//  Created by Ben Shutt on 23/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Alamofire
import Foundation

/// An endpoint that executes a URL request and decodes the response into a model.
public protocol DecodableRequest: URLRequestMaker {
    /// Model expected in the response body that will be decoded from data.
    /// - Note: `Empty` can be used when a response is empty. E.g. on HTTP status code 204.
    associatedtype ResponseBody: Decodable, Sendable

    /// The Alamofire session.
    ///
    /// Defaults to `.default`.
    var session: Session { get }

    /// Define how the response data should be decoded.
    ///
    /// Defaults to `JSONDecoder()`.
    var decoder: DataDecoder { get }

    /// The request interceptor.
    ///
    /// Defaults to `nil`.
    var interceptor: RequestInterceptor? { get }

    /// Validate the response.
    ///
    /// Defaults to `true`.
    var validate: Bool { get }
}

// MARK: - Extensions

public extension DecodableRequest {
    var session: Session {
        .default
    }

    var decoder: DataDecoder {
        JSONDecoder()
    }

    var interceptor: RequestInterceptor? {
        nil
    }

    var validate: Bool {
        true
    }

    // MARK: Request

    /// Execute the data request decoding the response
    /// - Returns: The response body
    @discardableResult
    func request() async throws -> ResponseBody {
        try await session.request(
            self,
            interceptor: interceptor
        )
        .decodeValue(
            ResponseBody.self,
            validate: validate,
            decoder: decoder
        )
    }
}
