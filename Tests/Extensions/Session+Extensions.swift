//
//  Session+Extensions.swift
//  DataRequest
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import Alamofire
import DataRequest

extension Session {

    /// Make custom `Session` with event monitors
    static let worldTime = Session(eventMonitors: [
        ResponseEventMonitor()
    ])
}
