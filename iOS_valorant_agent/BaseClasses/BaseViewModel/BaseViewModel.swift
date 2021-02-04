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
    let mainRepo = MainRepo()

    public var apiExceptionPublisher: AnyPublisher<AppError, Never> {
        return apiExceptionSubject.eraseToAnyPublisher()
    }

}
