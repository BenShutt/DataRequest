//
//  URLRequestMakerTests.swift
//  DataRequest
//
//  Created by Ben Shutt on 03/01/2025.
//  Copyright © 2025 Ben Shutt. All rights reserved.
//

import Foundation
import Alamofire
import Testing
@testable import DataRequest

// MARK: - EmptyURLRequestMaker

struct EmptyURLRequestMaker: URLRequestMaker {
    let urlComponents = URLComponents()
}

// MARK: - URLRequestMakerWithBody

struct URLRequestMakerWithBody: URLRequestMaker {
    let urlComponents = URLComponents()
    let method: HTTPMethod = .post

    @Atomic var bodyCount = 0

    var headers: HTTPHeaders {
        .default.appending(.acceptJSON)
    }

    var body: HTTPBody? {
        bodyCount += 1
        return HTTPBody(
            contentType: .contentTypeData,
            body: Data()
        )
    }
}

// MARK: - URLRequestMakerTests

@Suite("Unit tests for URLRequestMaker")
struct URLRequestMakerTests {

    // MARK: - Defaults

    @Test func defaultMethod() throws {
        let sut = EmptyURLRequestMaker()
        let urlRequest = try sut.urlRequest
        #expect(urlRequest.httpMethod == "GET")
    }

    @Test func defaultHeaders() throws {
        let sut = EmptyURLRequestMaker()
        let urlRequest = try sut.urlRequest
        let headers = urlRequest.allHTTPHeaderFields ?? [:]
        #expect(Set(headers.keys) == [
            "Accept-Encoding",
            "Accept-Language",
            "User-Agent",
        ])
    }

    @Test func defaultBody() throws {
        let sut = EmptyURLRequestMaker()
        let urlRequest = try sut.urlRequest
        #expect(urlRequest.httpBody == nil)
    }

    // MARK: - Defaults

    @Test func asURLRequestCallsBodyOnce() throws {
        let sut = URLRequestMakerWithBody()
        _ = try sut.asURLRequest()
        #expect(sut.bodyCount == 1)
    }

    @Test func withBodyMethod() throws {
        let sut = URLRequestMakerWithBody()
        let urlRequest = try sut.asURLRequest()
        #expect(urlRequest.httpMethod == "POST")
    }

    @Test func withBodyHeaders() throws {
        let sut = URLRequestMakerWithBody()
        let urlRequest = try sut.asURLRequest()
        let headers = urlRequest.allHTTPHeaderFields ?? [:]
        #expect(Set(headers.keys) == [
            "Accept",
            "Accept-Encoding",
            "Accept-Language",
            "Content-Type",
            "User-Agent"
        ])
        #expect(headers["Accept"] == "application/json")
        #expect(headers["Content-Type"] == "application/octet-stream")
    }
}
