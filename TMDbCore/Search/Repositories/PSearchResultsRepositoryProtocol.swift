//
//  SearchResultsRepositoryProtocol.swift
//  TMDbCore
//
//  Created by Administrador on 27/11/17.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import RxSwift

protocol PSearchResultsRepositoryProtocol {
    func searchResults(withQuery query: String, page: Int) -> Observable<[SearchResult]>
}
