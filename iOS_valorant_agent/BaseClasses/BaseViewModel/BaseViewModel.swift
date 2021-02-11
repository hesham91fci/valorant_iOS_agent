//
//  BaseViewModel.swift
//  iOS_valorant_agent
//
//  Created by Hesham Ali on 2/2/21.
//

import Foundation
import Combine
import Alamofire
open class BaseViewModel {
    private var apiExceptionSubject: PassthroughSubject<AppError, Never> = PassthroughSubject<AppError, Never>()
    var subscriptions: [AnyCancellable] = []

    func handleAppError(error: Subscribers.Completion<AppError>) {
        switch error {
        case .failure(let appError):
            self.apiExceptionSubject.send(appError)
        default:
            print("finished")
        }
    }

    func handleAppError(error: AppError) {
        self.apiExceptionSubject.send(error)
    }

    public var apiExceptionPublisher: AnyPublisher<AppError, Never> {
        return apiExceptionSubject.eraseToAnyPublisher()
    }

    deinit {
        subscriptions.removeAll()
    }

}
