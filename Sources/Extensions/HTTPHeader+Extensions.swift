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
    static let acceptJSON = HTTPHeader(name: "Accept", value: "application/json")

    /// `"Content-Type: application/json"`
    static let contentTypeJSON: HTTPHeader = .contentType("application/json")
}
