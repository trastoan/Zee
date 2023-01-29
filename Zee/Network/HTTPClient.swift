//
//  HTTPClient.swift
//  Zee
//
//  Created by Yuri on 29/01/23.
//

import Foundation

public protocol HTTPClient {
    func requestObject<Model: Decodable>(endpoint: ServiceEndpoint) async throws -> Model
}

public enum HTTPClientError: Error, Equatable {
    case urlCreation
    case invalidObject
}

public struct HTTPWorker: HTTPClient {

    let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func requestObject<Model>(endpoint: ServiceEndpoint) async throws -> Model where Model: Decodable {
        let url = try url(from: endpoint)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.value
        let (data, _) = try await session.data(from: url)

        do {
            let result = try JSONDecoder().decode(Model.self, from: data)
            return result
        } catch {
            throw HTTPClientError.invalidObject
        }

    }

    func url(from endpoint: ServiceEndpoint) throws -> URL {
        var urlComponent = URLComponents(string: endpoint.baseUrl)
        urlComponent?.path = endpoint.path
        urlComponent?.queryItems = endpoint.queryParameters?.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let url = urlComponent?.url else {
            throw HTTPClientError.urlCreation
        }
        return url
    }
}
