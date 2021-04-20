//
//  APIRequest.swift
//  APILayerProj
//
//  Created by marc helou on 2/19/21.
//
import Combine
import UIKit

public class NetworkService: NetworkServiceProtocol {
    private var url: URL?
    private var method: HTTPMethod = .get
    private var body: Data?
    private var queries: [String: String]?
    private var headers: [String: String] = [:]
    
    @discardableResult
    public func withURL(_ url: String) -> Self {
        self.url = URL(string: url)
        return self
    }
    
    @discardableResult
    public func withMethod(_ method: HTTPMethod) -> Self {
        self.method = method
        return self
    }
    
    @discardableResult
    public func withBody<Request: Codable>(_ body: Request) -> Self {
        self.body = try? JSONEncoder().encode(body)
        return self
    }
    
    @discardableResult
    public func withQueries(_ queries: [String: String]) -> Self {
        self.queries = queries
        return self
    }
    
    @discardableResult
    public func withHeaders(_ headers: [String: String]) -> Self {
        self.headers = headers
        return self
    }
    
    func buildURL() throws -> URL {
        guard let url = url else { throw NetworkError.wrongURLFormat }
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        if let queries = queries {
            urlComponents?.queryItems = queries.map({URLQueryItem(name: $0.key, value: $0.value)})
        }
        return urlComponents?.url ?? url
    }
    
    private func buildRequest() throws -> URLRequest {
        var request = URLRequest(url: try buildURL())
        request.httpMethod = self.method.rawValue
        request.httpBody = self.body
        self.headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = self.headers
        URLSession.shared.configuration.allowsCellularAccess = true
        URLSession.shared.configuration.shouldUseExtendedBackgroundIdleMode = true
        URLSession.shared.configuration.waitsForConnectivity = true
        return request
    }
    
    func decode<T: Codable>(_ data: Data) throws -> T {
        log((try? JSONSerialization.jsonObject(with: data, options: [])) ?? [:])
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func request<Response: Codable>() -> Future<Response, NetworkError> {
        Future { [weak self] promise in
            do {
                guard let self = self else { return }
                let request = try self.buildRequest()
                URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let error = error {
                        promise(.failure(NetworkError.error(error.localizedDescription)))
                        return
                    }
                    guard let httpResponse = response as? HTTPURLResponse,
                        let data = data else {
                            promise(.failure(NetworkError.unknown))
                            return
                    }
                    if (200...299).contains(httpResponse.statusCode) {
                        do {
                            let body: Response = try self.decode(data)
                            promise(.success(body))
                        } catch {
                            log(String(data: data, encoding: .utf8) ?? "")
                            promise(.failure(NetworkError.notCodable))
                        }
                    } else {
                        do {
                            let body: ServerError = try self.decode(data)
                            promise(.failure(NetworkError.error(body.fault.faultstring)))
                        } catch {
                            promise(.failure(NetworkError.notCodable))
                        }
                    }
                }.resume()
            } catch {
                promise(.failure(NetworkError.error(error.localizedDescription)))
            }
        }
    }
}
