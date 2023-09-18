//
//  JSONBody.swift
//  DataRequest
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import Alamofire

/// Defines a JSON request body
public protocol JSONBody: RequestBody {

    /// The request body that will be encoded into JSON data
    associatedtype Body: Encodable

    /// Make request body that will be encoded into JSON data
    var jsonBody: Body { get }

    /// The encoder which makes the JSON data
    var encoder: JSONEncoder { get }
}

// MARK: - Extensions

public extension JSONBody {

    /// Defaults to `.contentTypeJSON`
    var contentType: HTTPHeader {
        .contentTypeJSON
    }

    /// Defaults to `JSONEncoder()`
    var encoder: JSONEncoder {
        JSONEncoder()
    }

    /// Encode `jsonBody` with `encoder`
    var body: Data {
        get throws {
            try encoder.encode(jsonBody)
        }
    }
}
