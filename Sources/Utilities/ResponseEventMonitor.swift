//
//  ResponseEventMonitor.swift
//  DataRequest
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import Alamofire

/// `EventMonitor` that logs responses
public struct ResponseEventMonitor: EventMonitor {

    /// `DispatchQueue` to execute on
    public var queue: DispatchQueue { .main }

    /// Public initializer
    public init() {}

    public func request<Value>(
        _ request: DataRequest,
        didParseResponse response: DataResponse<Value, AFError>
    ) {
        debugPrint(response)
    }
}
