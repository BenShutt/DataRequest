//
//  RequestBody.swift
//  DataRequest
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import Alamofire

/// Define a HTTP request body
public protocol RequestBody {

    /// `HTTPHeader` for the content type of the body
    var contentType: HTTPHeader { get }

    /// Request body data
    var body: Data { get throws }
}
