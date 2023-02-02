//
//  NetworkTests.swift
//  ZeeTests
//
//  Created by Yuri on 29/01/23.
//

import XCTest
@testable import Zee

final class MazeNetworkTests: XCTestCase {
    var sut: HTTPWorker!
    var localSut: LocalWorker!

    override func setUp() {
        super.setUp()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let mockSession = URLSession(configuration: config)

        sut = HTTPWorker(session: mockSession)
        localSut = LocalWorker()
    }

    func test_should_decode() async throws {
        let mocker = Mocker(statusCode: 200)
        guard let testData = MockItem.mockedData() else {
            XCTFail("Should have valid data")
            return
        }
        mocker.testData = testData
        URLProtocolMock.mock = mocker

        let decoded: MockItem = try await sut.requestObject(endpoint: MockRoute.goodRoute)

        XCTAssertEqual(decoded.testString, "Test")
    }

    func test_invalidDataShould_withNoCache_throwError() async {
        let mocker = Mocker(statusCode: 200)
        mocker.testData = "1234".data(using: .utf8)
        URLProtocolMock.mock = mocker

        do {
            let _: MockItem = try await sut.requestObject(endpoint: MockRoute.goodRoute)
        } catch {
            guard let clientError = error as? LocalClientError else {
                XCTFail("It should be a LocalClientError")
                return
            }
            XCTAssertNotNil(clientError)
            XCTAssertEqual(clientError, .dataNotFound)
        }
    }

    func test_invalidDataShould_withCache_Decode() async {
        let mocker = Mocker(statusCode: 200)
        mocker.testData = "1234".data(using: .utf8)
        URLProtocolMock.mock = mocker
        insertLocalData(on: MockRoute.goodRoute)

        do {
            let mockedItem: MockItem = try await sut.requestObject(endpoint: MockRoute.goodRoute)
            XCTAssertEqual(mockedItem.testString, "Test")
            removeLocalData(on: MockRoute.goodRoute)
        } catch {
            XCTFail("Should not be throwing a error")
        }
    }

    func test_url_shouldThrow_urlCreation() {
        do {
            _ = try sut.url(from: MockRoute.throwableRoute)
            XCTFail("It should throw")
        } catch {
            guard let clientError = error as? HTTPClientError else {
                XCTFail("It should be a HTTPClientError")
                return
            }
            XCTAssertNotNil(clientError)
            XCTAssertEqual(clientError, .urlCreation)
        }
    }

    func test_url_shouldWork() {
        do {
            let url = try sut.url(from: MockRoute.goodRoute)
            let expectedUrl = "https://test.endpoint.com/path"
            XCTAssertEqual(expectedUrl, url.absoluteString)
        } catch {
            XCTFail("It should not fail")
        }
    }

    func test_url_shouldWork_withQueryParameters() {
        do {
            let url = try sut.url(from: MockRoute.goodRouteWithQueryParameters)
            let expectedUrl = "https://test.endpoint.com/path?q=query"
            XCTAssertEqual(expectedUrl, url.absoluteString)
        } catch {
            XCTFail("It should not fail")
        }
    }

    private func insertLocalData(on endpoint: ServiceEndpoint) {
        guard let testData = MockItem.mockedData() else {
            XCTFail("Should have valid data")
            return
        }

        do {
            try localSut.storeData(data: testData, endpoint: endpoint)
        } catch {
            XCTFail("Unable to save date")
        }
    }

    private func removeLocalData(on endpoint: ServiceEndpoint) {
        do {
            try localSut.removeData(endpoint: endpoint)
        } catch {
            XCTFail("Unable to save date")
        }
    }
}

