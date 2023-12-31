//
//  URLSession.swift
//  ImageFeed
//
//  Created by Артем Калюжин on 10.09.2023.
//

import Foundation

enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
    case decodingError
}

extension URLSession {
    func objectTask<T:Decodable>(for request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionTask {
        let fulfilCompletion: (Result<T, Error>) -> Void = { result in
            DispatchQueue.main.async {
                 completion(result)
            }
        }
        let task = dataTask(with: request) { data, response, error in
            if let data = data, let response = response as? HTTPURLResponse {
                if 200..<300 ~= response.statusCode {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let decodedModel = try jsonDecoder.decode(T.self, from: data)
                        fulfilCompletion(.success(decodedModel))
                    } catch {
                        fulfilCompletion(.failure(NetworkError.decodingError))
                    }
                } else {
                    fulfilCompletion(.failure(NetworkError.httpStatusCode(response.statusCode)))
                }
            } else if let error {
                fulfilCompletion(.failure(NetworkError.urlRequestError(error)))
            } else {
                fulfilCompletion(.failure(NetworkError.urlSessionError))
            }
        }
        task.resume()
        return task
    }
}
