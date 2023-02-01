//
//  HTTPClient.swift
//  Zee
//
//  Created by Yuri on 29/01/23.
//

import Foundation

protocol HTTPClient {
    func requestObject<Model: Decodable>(endpoint: ServiceEndpoint) async throws -> Model
}

enum HTTPClientError: Error, Equatable {
    case urlCreation
    case invalidObject
}

struct HTTPWorker: HTTPClient {

    let session: URLSession
    let localClient: LocalClient

    init(session: URLSession = .shared, localClient: LocalClient = LocalWorker()) {
        self.session = session
        self.localClient = localClient
    }

    func requestObject<Model>(endpoint: ServiceEndpoint) async throws -> Model where Model: Decodable {
        let url = try url(from: endpoint)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.value

        do {
            let (data, _) = try await session.data(from: url)
            let result = try JSONDecoder().decode(Model.self, from: data)
            try? localClient.storeData(data: data, endpoint: endpoint)
            return result
        } catch {
            do {
                let data = try localClient.retrieveData(endpoint: endpoint)
                let result = try JSONDecoder().decode(Model.self, from: data)
                return result
            } catch {
                throw LocalClientError.dataNotFound
            }
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
