//
//  AppError.swift
//  iOS_valorant_agent
//
//  Created by Hesham Ali on 2/2/21.
//

import Foundation
public enum ErrorType: String, Codable {
    case noConnection           //Status code -1
    case unauthorized           //Status code 401
    case forbidden              //Status code 403
    case notFound               //Status code 404
    case conflict               //Status code 409
    case internalServerError    //Status code 500
    case unkown
    case validation
    case connectionTimedOut
}

public struct AppError: Error, Codable {

    var message: String?
    var errorType: ErrorType = .unkown
    var errorCode: Int! {
        willSet {
            switch newValue {
            case -1:
                self.errorType = .noConnection
                self.message = "No Connection"
            case -2:
                self.errorType = .connectionTimedOut
                self.message = "Connection timed out"
            case 401:
                self.errorType = .unauthorized
                self.message = "Unauthorized"
            case 403:
                self.errorType = .forbidden
                self.message = "Forbidden"
            case 404:
                self.errorType = .notFound
                self.message = "Resource not found"
            case 409:
                self.errorType = .conflict
                self.message = "Unknown"
            case 500:
                self.errorType = .internalServerError
                self.message = "Internal server error"
            case 1000:
                self.errorType = .validation
                self.message = "Validation error"
            default:
                self.errorType = .unkown
                self.message = "Unknown"
            }
        }
    }
}
