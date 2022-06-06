//
//  NetworkService.swift
//  TestMamleev
//
//  Created by Andrey on 25.05.2022.
//

import Foundation

class NetworkService {
    
    func getMessages(counter: String, completion: @escaping MessagesCompletion) {
        getRequest(URLString: baseMessagesURL  + counter) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                do {
                    let jsonData = try? JSONDecoder().decode(MessagesResponse.self, from: data)
                    completion(.success(jsonData?.result ?? []))
                }
            }
        }
    }
}

extension NetworkService {
    
    private func getRequest(URLString: String, completion: @escaping ResultCompletion) {
        guard let url = URL(string: URLString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
    }
}
