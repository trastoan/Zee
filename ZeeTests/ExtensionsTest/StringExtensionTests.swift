//
//  StringExtensionTests.swift
//  ZeeTests
//
//  Created by Yuri on 02/02/23.
//

import Foundation
import XCTest
@testable import Zee

final class StringExtensionTests: XCTestCase {
    func test_capitalizeFirstLetter() {
        let sut = "teste"
        let output = sut.capitalizedFirstLetter
        XCTAssertEqual(output, "Teste")
    }
}
