//
//  ServiceEndpoint.swift
//  Zee
//
//  Created by Yuri on 29/01/23.
//

import Foundation

public protocol ServiceEndpoint {
    var path: String { get }
    var baseUrl: String { get }
    var queryParameters: [String: String]? { get }
    var method: HttpMethod { get }
}

public enum HttpMethod: String {
    case get, delete

    public var value: String { rawValue.uppercased() }
}

