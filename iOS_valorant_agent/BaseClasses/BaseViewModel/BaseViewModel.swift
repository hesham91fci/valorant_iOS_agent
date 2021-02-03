//
//  BaseViewModel.swift
//  iOS_valorant_agent
//
//  Created by Hesham Ali on 2/2/21.
//

import Foundation
import Combine
import Alamofire
open class BaseViewModel<T: Codable, E: Codable> {
    private var apiResponseSubject: PassthroughSubject<T, Never> = PassthroughSubject<T, Never>()
    private var apiErrorSubject: PassthroughSubject<E, Never> = PassthroughSubject<E, Never>()
    private var apiExceptionSubject: PassthroughSubject<AppError, Never> = PassthroughSubject<AppError, Never>()
    private var subscriptions: [AnyCancellable] = []
    private var networkHandler = NetworkHandler()
    public var environment: Environment {
        return .development
    }
    public var apiResponsePublisher: AnyPublisher<T, Never> {
        return apiResponseSubject.eraseToAnyPublisher()
    }

    public var apiErrorPublisher: AnyPublisher<E, Never> {
        return apiErrorSubject.eraseToAnyPublisher()
    }

    public var apiExceptionPublisher: AnyPublisher<AppError, Never> {
        return apiExceptionSubject.eraseToAnyPublisher()
    }

    public func getData(url: String, method: Alamofire.HTTPMethod, params: Alamofire.Parameters?, encoding: Alamofire.ParameterEncoding, headers: Alamofire.HTTPHeaders?) {
        let networkPublisher: Future<(T?, E?, AppError?), Never> = networkHandler.performRequest(url: environment.rawValue + url, method: method, params: params, encoding: encoding, headers: headers)
        networkPublisher.sink { [weak self] (successResponse, errorResponse, appError) in
            if let successResponse = successResponse {
                self?.apiResponseSubject.send(successResponse)
            }

            if let errorResponse = errorResponse {
                self?.apiErrorSubject.send(errorResponse)
            }

            if let appError = appError {
                self?.apiExceptionSubject.send(appError)
            }
        }.store(in: &subscriptions)

    }

}
