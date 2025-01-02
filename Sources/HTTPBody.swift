//
//  HTTPBody.swift
//  DataRequest
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import Alamofire

/// Defines a HTTP request body
public struct HTTPBody {

    /// `HTTPHeader` for the content type of the body
    public var contentType: HTTPHeader

    /// Request body data
    public var body: Data

    /// Public memberwise initializer
    public init(contentType: HTTPHeader, body: Data) {
        self.contentType = contentType
        self.body = body
    }
}

// MARK: - HTTPBody + JSON

extension HTTPBody {

    /// Make a JSON request body
    /// - Parameters:
    ///   - model: Object that will be encoded into JSON data
    ///   - encoder: The encoder which makes the JSON data
    /// - Returns: The JSON request body
    static func json(
        _ encodable: some Encodable,
        encoder: JSONEncoder = JSONEncoder()
    ) throws -> HTTPBody {
        try HTTPBody(
            contentType: .contentTypeJSON,
            body: encoder.encode(encodable)
        )
    }
}

// MARK: - HTTPBody + Data

extension HTTPBody {

    /// Make a `Data` request body
    /// - Parameter data: The data of the body
    /// - Returns: The `Data` request body
    static func data(_ data: Data) -> HTTPBody {
        HTTPBody(
            contentType: .contentTypeData,
            body: data
        )
    }
}
