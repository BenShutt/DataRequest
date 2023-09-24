//
//  DataRequest+Extensions.swift
//  DataRequest
//
//  Created by Ben Shutt on 23/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import Alamofire

public extension DataRequest {
    
    /// Validate if required
    /// - Parameter value: Should validate
    /// - Returns: `Self`
    private func validate(if value: Bool) -> Self {
        value ? validate() : self
    }

    /// Decode the response body and await the value, validating if required.
    /// - Parameters:
    ///   - decodable: The model to decode
    ///   - validate: If true, validate the response, defaults to `true`
    ///   - decoder: The data decoder to use, defaults to `JSONDecoder()`
    /// - Returns: `ResponseBody`
    func decodeValue<ResponseBody: Decodable>(
        _ responseBody: ResponseBody.Type,
        validate: Bool = true,
        decoder: DataDecoder = JSONDecoder()
    ) async throws -> ResponseBody {
        try await self
            .validate(if: validate)
            .serializingDecodable(responseBody, decoder: decoder)
            .value
    }

    /// Decode the response body and await the value, validating if required.
    /// - Parameters:
    ///   - validate: If true, validate the response, defaults to `true`
    ///   - decoder: The data decoder to use, defaults to `JSONDecoder()`
    /// - Returns: `ResponseBody`
    @discardableResult
    func decodeValue<ResponseBody: Decodable>(
        validate: Bool = true,
        decoder: DataDecoder = JSONDecoder()
    ) async throws -> ResponseBody {
        try await decodeValue(
            ResponseBody.self,
            validate: validate,
            decoder: decoder
        )
    }
}
