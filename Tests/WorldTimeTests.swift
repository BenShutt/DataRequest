//
//  WorldTimeTests.swift
//  DataRequestTests
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

@testable import DataRequest
import Testing

@Suite("Integration tests for the World Time API", .disabled())
struct WorldTimeTests {
    private let timeZone = "Europe/London"

    @Test func worldTimeAPI() async throws {
        let worldTime = try await GetWorldTime(timeZone: timeZone).request()
        #expect(worldTime.timezone == timeZone)
    }
}
