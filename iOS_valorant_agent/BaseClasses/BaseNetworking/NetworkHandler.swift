//
//  NetworkHandler.swift
//  iOS_valorant_agent
//
//  Created by Hesham Ali on 2/2/21.
//

import Foundation
import Alamofire
import Combine
public struct ResponseData<T: Codable, E: Codable>: Codable {
    let sucessResponse: T?
    let errorResponse: E?
    let appError: AppError?
}
public class NetworkHandler {
    public var environment: Environment {
        return .development
    }
    public func performRequest<T: Codable>(url: String, method: HTTPMethod, params: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?) -> AnyPublisher<T, AppError> {
        guard let url = URL(string: environment.rawValue+url) else {
            return Fail(error: AppError(message: "Invalid URL", errorCode: nil)).eraseToAnyPublisher()
        }

        return AF.request(url,
                         method: method,
                         parameters: params,
                         encoding: encoding,
                         headers: headers) { $0.timeoutInterval = 30 }
            .validate()
            .publishDecodable(type: T.self)
            .value()
            .mapError { (error) -> AppError in
                return AppError(message: error.localizedDescription, errorCode: error.responseCode)
            }
            .eraseToAnyPublisher()

    }
}
