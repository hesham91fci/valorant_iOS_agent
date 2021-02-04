//
//  AppError.swift
//  iOS_valorant_agent
//
//  Created by Hesham Ali on 2/2/21.
//

import Foundation
public struct AppError: Error, Codable {

    let message: String?
    let errorCode: Int?
}
