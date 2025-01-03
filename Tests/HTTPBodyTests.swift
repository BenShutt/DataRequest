//
//  HTTPBodyTests.swift
//  DataRequest
//
//  Created by Ben Shutt on 03/01/2025.
//  Copyright © 2025 Ben Shutt. All rights reserved.
//

import Foundation
import Testing
@testable import DataRequest

// MARK: - EncodableBody

struct EncodableBody: Encodable {
    var int = 1
    var string = "123"
}

// MARK: - HTTPBodyTests

@Suite("Unit tests for HTTPBody")
struct HTTPBodyTests {

    // MARK: - Data

    @Test func dataHeader() throws {
        let httpBody = HTTPBody.data(Data())
        #expect(httpBody.contentType == .init(
            name: "Content-Type",
            value: "application/octet-stream"
        ))
    }

    @Test func dataBody() throws {
        let httpBody = HTTPBody.data(Data())
        #expect(httpBody.body == Data())
    }

    // MARK: - JSON

    @Test func jsonHeader() throws {
        let httpBody = try HTTPBody.json(EncodableBody())
        #expect(httpBody.contentType == .init(
            name: "Content-Type",
            value: "application/json"
        ))
    }

    @Test func jsonBody() throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys]

        let httpBody = try HTTPBody.json(EncodableBody(), encoder: encoder)
        let json = try #require(String(data: httpBody.body, encoding: .utf8))

        #expect(json == """
            {"int":1,"string":"123"}
            """
        )
    }
}
