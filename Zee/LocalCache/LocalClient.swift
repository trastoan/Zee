//
//  LocalClient.swift
//  Zee
//
//  Created by Yuri on 01/02/23.
//

import Foundation

protocol LocalClient {
    func storeData(data: Data, endpoint: ServiceEndpoint) throws
    func retrieveData(endpoint: ServiceEndpoint) throws -> Data
}

public enum LocalClientError: Error, Equatable {
    case dataNotFound
    case unableToSaveData
    case invalidURL
}

struct LocalWorker: LocalClient {

    private var fileDirectory: URL

    init(fileManager: FileManager = FileManager.default, fileDirectory: URL? = nil) {
        if fileDirectory == nil {
            self.fileDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        } else {
            self.fileDirectory = fileDirectory!
        }
    }

    func storeData(data: Data, endpoint: ServiceEndpoint) throws {
        do {
            try data.write(to: buildURL(endpoint: endpoint))
        } catch {
            throw LocalClientError.unableToSaveData
        }
    }

    func retrieveData(endpoint: ServiceEndpoint) throws -> Data {
        do {
            return try Data(contentsOf: buildURL(endpoint: endpoint))
        } catch {
            throw LocalClientError.dataNotFound
        }
    }

    @discardableResult
    func removeData(endpoint: ServiceEndpoint) throws -> Bool {
        let filemanager = FileManager.default
        try filemanager.removeItem(at: buildURL(endpoint: endpoint))
        return true
    }

    private func buildURL(endpoint: ServiceEndpoint) throws -> URL {
        var urlComponent = URLComponents(string: endpoint.baseUrl)
        urlComponent?.path = endpoint.path
        urlComponent?.queryItems = endpoint.queryParameters?.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let finalPath = urlComponent?.url?.absoluteString,
              let rangeOfHost = urlComponent?.rangeOfHost?.upperBound
        else {
            throw LocalClientError.invalidURL
        }

        let path = String(finalPath[rangeOfHost...].dropFirst()).replacingOccurrences(of: "/", with: "-")
        let finalURL = fileDirectory.appendingPathExtension(path)

        return finalURL
    }
}
