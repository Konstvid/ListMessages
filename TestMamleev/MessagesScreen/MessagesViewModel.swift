//
//  MessagesViewModel.swift
//  TestMamleev
//
//  Created by Andrey on 25.05.2022.
//

import Foundation


class MessagesViewModel {
    
    var errorComletion: ErrorCompletion?
    private let network = NetworkService()
    private let count = 20
    
    func getMessages(page: Int, completion: @escaping ([String]) -> ()) {
        let counter = page == 0 ? "0" : String(page * count)
        network.getMessages(counter: counter) {[ weak self ] result in
            switch result {
            case .success(let news):
                completion(news)
            case .failure(let error):
                self?.errorComletion?(error)
            }
        }
    }
}
