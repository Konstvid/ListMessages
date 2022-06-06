//
//  Constants.swift
//  TestMamleev
//
//  Created by Andrey on 25.05.2022.
//

import Foundation

typealias ResultCompletion = (Result<Data, Error>) -> ()
typealias MessagesCompletion = (Result<[String], Error>) -> ()
typealias ErrorCompletion = (Error) -> ()

let baseMessagesURL = "https://numero-logy-app.org.in/getMessages?offset="
