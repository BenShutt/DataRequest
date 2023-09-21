//
//  DataRequest.swift
//  DataRequest
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import Alamofire

/// An endpoint that executes a data request and decodes the response into a model.
public protocol DataRequest {

    /// Model expected in the response body that will be decoded from data.
    /// - Note: `Empty` can be used as the `Model` type when a response is empty.
    associatedtype ResponseBody: Decodable

    /// The Alamofire request session
    var session: Session { get }

    /// Decoder of data
    var decoder: DataDecoder { get }

    /// `HTTPMethod`
    var method: HTTPMethod { get }

    /// `URLComponents`
    var urlComponents: URLComponents { get }

    /// The data to accept from the server
    var acceptHeader: HTTPHeader { get }

    /// Additional `HTTPHeaders`
    var additionalHeaders: HTTPHeaders { get }
}

// MARK: - Extensions

public extension DataRequest {

    /// Defaults to `.default`
    var session: Session {
        .default
    }

    /// Defaults to `.get`
    var method: HTTPMethod {
        .get
    }

    /// Defaults to empty
    var additionalHeaders: HTTPHeaders {
        []
    }

    // MARK: Helper

    /// Get the `HTTPHeaders`
    private var headers: HTTPHeaders {
        var headers: HTTPHeaders = .default
        headers.append(acceptHeader)
        if let requestBody = self as? RequestBody {
            headers.append(requestBody.contentType)
        }
        headers.append(additionalHeaders)
        return headers
    }

    /// Make a `URLRequest`
    private var urlRequest: URLRequest {
        get async throws {
            var request = try URLRequest(url: urlComponents, method: method)
            request.headers = headers
            if let requestBody = self as? RequestBody {
                request.httpBody = try await requestBody.body
            }
            return request
        }
    }

    // MARK: Request

    /// Request and decode `ResponseBody`
    /// - Returns: `ResponseBody`
    @discardableResult
    func request() async throws -> ResponseBody {
        try await session
            .request(urlRequest)
            .validate()
            .serializingDecodable(ResponseBody.self, decoder: decoder)
            .value
    }
}
