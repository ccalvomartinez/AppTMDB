//
//  PMovieRepositoryProtocol.swift
//  TMDbCore
//
//  Created by Administrador on 27/11/17.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import RxSwift

protocol PMovieRepositoryProtocol {
    
    func movie(withIdentifier identifier: Int64) -> Observable<MovieDetail>
}

protocol PShowRepositoryProtocol {
    
    func show(withIdentifier identifier: Int64) -> Observable<ShowDetail>
}

protocol PPersonRepositoryProtocol {
    
    func person(withIdentifier identifier: Int64) -> Observable<PersonDetail>
}
