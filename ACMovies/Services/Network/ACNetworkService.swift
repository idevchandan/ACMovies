//
//  ACNetworkService.swift
//  ACMovies
//
//  Created by Chandan Kumar on 30/03/21.
//

import Foundation

protocol ACNetworkSession {
  func dataTask(with url: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: ACNetworkSession {}

final class ACNetworkService {
    private let session: ACNetworkSession
    private let config: ACNetworkConfig
    
    init(session: ACNetworkSession = URLSession.shared,
         config: ACNetworkConfig) {
        self.session = session
        self.config = config
    }

    func requestData(with endpoint: ACEndPoint, completion: @escaping (Result<Data, ACNetworkError>) -> Void) {
        guard let request = self.urlRequest(with: endpoint) else {
            return
        }

        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.nonFatal(error: error)))
                    return
                }

                if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                    completion(.failure(.httpError(statusCode: httpResponse.statusCode)))
                    return
                }

                guard let data = data else {
                    completion(.failure(.noContentReturned))
                    return
                }

                completion(.success(data))
            }
        }.resume()
    }

    private func urlRequest(with endpoint: ACEndPoint) -> URLRequest? {
        var urlComponents = URLComponents(string: config.baseURL.absoluteString)
        urlComponents?.path = "/\(endpoint.version)/\(endpoint.path)"
        urlComponents?.setQueryItems(with: config.queryParameters)

        guard let url = urlComponents?.url else {
            return nil
        }

        return URLRequest(url: url)
    }
}

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}

