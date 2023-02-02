//
//  UIFontExtensionTests.swift
//  ZeeTests
//
//  Created by Yuri on 02/02/23.
//
import UIKit
import XCTest
@testable import Zee

final class UIFontExtensionTests: XCTestCase {

    func test_fontCreation() throws {
        let font = UIFont.font(named: "Helvetica", size: 22, weight: .bold)
        XCTAssertEqual(font.familyName, "Helvetica")
        XCTAssertEqual(font.pointSize, 22.0)
        let traits = font.fontDescriptor.object(forKey: .traits) as? [UIFontDescriptor.TraitKey: Any]
        let weightValue = try XCTUnwrap(traits?[.weight] as? CGFloat)
        XCTAssertEqual(weightValue, UIFont.Weight.bold.rawValue, accuracy: 0.1)
    }
}
