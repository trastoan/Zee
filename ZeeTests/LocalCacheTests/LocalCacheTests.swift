//
//  LocalCacheTests.swift
//  ZeeTests
//
//  Created by Yuri on 02/02/23.
//

import XCTest
@testable import Zee

final class LocalCacheTests: XCTestCase {
    var sut: LocalWorker!

    override func setUp() {
        super.setUp()
        sut = LocalWorker()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testData_dataNotAvailable_shouldThrow() {
        do {
            _ = try sut.retrieveData(endpoint: MockRoute.goodRoute)
        } catch {
            guard let localError = error as? LocalClientError else {
                XCTFail("It should be a Local Error")
                return
            }
            XCTAssertNotNil(localError)
            XCTAssertEqual(localError, .dataNotFound)
        }
    }

    func testStoreData_badRoute_shouldThrow() {
        do {
            _ = try sut.storeData(data: Data(), endpoint: MockRoute.throwableRoute)
        } catch {
            guard let localError = error as? LocalClientError else {
                XCTFail("It should be a Local Error")
                return
            }
            XCTAssertNotNil(localError)
            XCTAssertEqual(localError, .unableToSaveData)
        }
    }
}
