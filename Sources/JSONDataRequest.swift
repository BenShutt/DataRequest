//
//  JSONDataRequest.swift
//  DataRequest
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import Alamofire

public protocol JSONDataRequest: DataRequest {}

// MARK: - Extensions

public extension JSONDataRequest {

    /// Defaults to `JSONDecoder()`
    var decoder: DataDecoder {
        JSONDecoder()
    }

    /// Defaults to `.acceptJSON`
    var acceptHeader: HTTPHeader {
        .acceptJSON
    }
}
