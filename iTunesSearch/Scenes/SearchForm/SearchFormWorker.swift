//
//  SearchFormWorker.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 27/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

import UIKit
import Combine

class SearchFormWorker {
    let searchService: SearchService
    var cancellables: Set<AnyCancellable> = []

    internal init(searchService: SearchService) {
        self.searchService = searchService
    }

    func fetchResults(term: String, for mediaTypes: [MediaTypeEntity], completionHandler: @escaping (Result<[(MediaTypeEntity, [ItunesMedia])], Error>) -> Void) {

        fetchResults(term: term, for: mediaTypes)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished: break
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }, receiveValue: { (results) in
                completionHandler(.success(results))
            })
            .store(in: &cancellables)
    }

    private func fetchResults(term: String, for mediaTypes: [MediaTypeEntity]) -> AnyPublisher<[(MediaTypeEntity, [ItunesMedia])], Error> {
        mediaTypes.publisher
            .flatMap({ self.fetchResult(term: term, for: $0) })
            .collect()
            .eraseToAnyPublisher()

    }

    private func fetchResult(term: String, for mediaType: MediaTypeEntity) -> AnyPublisher<(MediaTypeEntity, [ItunesMedia]), Error> {
        searchService.search(term: term, entity: mediaType.rawValue)
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .map(\.results)
            .replaceNil(with: [])
            .map({(mediaType, $0)})
            .eraseToAnyPublisher()
    }

}
