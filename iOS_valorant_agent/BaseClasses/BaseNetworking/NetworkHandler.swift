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
    private var appError: AppError = AppError()
    public func performRequest<T: Codable, E: Codable>(url: String, method: HTTPMethod, params: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?) -> Future<(T?, E?, AppError?), Never> {
        return Future<(T?, E?, AppError?), Never> { [weak self] promise in
            guard let url = URL(string: url) else {
                self?.appError.errorCode = -1
                return promise(.success((sucessResponse: nil, errorResponse: nil, appError: self?.appError)))
            }
            AF.request(url,
                             method: method,
                             parameters: params,
                             encoding: encoding,
                             headers: headers) { $0.timeoutInterval = 120 }
                .validate()
                .responseJSON { [weak self] (json) in
                    guard let self = self else {
                        return promise(.success((nil, nil, AppError(errorType: ErrorType.conflict, errorCode: 409))))
                    }
                    return self.processResponse(json: json, promise: promise)
                }

        }

    }

    func processResponse<T: Codable, E: Codable>(json: AFDataResponse<Any>, promise: ((Result<(T?, E?, AppError?), Never>) -> Void)) {
        let decoder = JSONDecoder()
        guard let data = json.data else {
            self.appError.errorCode = -2
            return promise(.success((nil, nil, self.appError)))
        }
        do {
            guard let response = json.response else {
                self.appError.errorCode = 409
                return promise(.success((nil, nil, self.appError)))
            }
            if response.statusCode < 300 {
                let successType = try decoder.decode(T.self, from: data)
                promise(.success((successType, nil, nil)))
            } else {
                let errorType = try decoder.decode(E.self, from: data)
                promise(.success((nil, errorType, nil)))
            }
        } catch _ {
            self.appError.errorCode = 409
            promise(.success((nil, nil, self.appError)))
        }
    }
}
