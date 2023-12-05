//
//  DataBody.swift
//  DataRequest
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import Alamofire

/// Defines a data request body
public protocol DataBody: RequestBody {}

// MARK: - Extensions

public extension DataBody {

    /// Defaults to `.contentTypeData`
    var contentType: HTTPHeader {
        .contentTypeData
    }
}
