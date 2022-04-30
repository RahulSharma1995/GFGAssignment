//
//  APIManager.swift
//  GFGAssignment
//
//  Created by Rahul Sharma on 30/04/22.
//

import Foundation
import Combine

enum EndPoint: String {
    case news = "https://api.rss2json.com/v1/api.json?rss_url=http://www.abc.net.au/news/feed/51120/rss.xml"
}

class APIManager {
    
    static let shared = APIManager()
    
    private init(){
        
    }
    
    
    private var cancellables = Set<AnyCancellable>()
    
    func getData(endPoint: EndPoint) -> Future<NewsAPIModel, Error> {
        return Future<NewsAPIModel, Error>  {[weak self] promise in
            guard let self = self, let url : URL = URL(string: endPoint.rawValue) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            var urlRequest: URLRequest = URLRequest(url: url)
            urlRequest.httpMethod = "post"
            URLSession.shared.dataTaskPublisher(for: urlRequest)
                .tryMap { (data , response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.responseError
                    }
                    return data
                }
                .decode(type: NewsAPIModel.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink { completion in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unknown))
                        }
                    }
                } receiveValue: { promise(.success($0))}
                .store(in: &self.cancellables)
        }
    }
    
}

enum NetworkError: Error {
    case invalidURL
    case responseError
    case unknown
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .responseError:
            return NSLocalizedString("Unexpected status code", comment: "Invalid response")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        }
    }
}
