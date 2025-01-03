//
//  HTTPHeader+Extensions.swift
//  DataRequest
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import Alamofire

public extension HTTPHeader {

    /// `"Accept: application/json"`
    static let acceptJSON: HTTPHeader = .accept("application/json")

    /// `"Content-Type: application/json"`
    static let contentTypeJSON: HTTPHeader = .contentType("application/json")

    /// `"Content-Type: application/octet-stream"`
    static let contentTypeData: HTTPHeader = .contentType("application/octet-stream")
}
