//
//  StringExtension.swift
//  Zee
//
//  Created by Yuri on 30/01/23.
//

import Foundation

extension String {
    var capitalizedFirstLetter: String {
        let first = self.prefix(1).capitalized
        let remaining = self.dropFirst().lowercased()
        return first + remaining
    }
}
