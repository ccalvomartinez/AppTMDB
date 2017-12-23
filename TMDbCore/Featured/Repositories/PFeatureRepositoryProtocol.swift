//
//  FeatureRepositoryProtocol.swift
//  TMDbCore
//
//  Created by Administrador on 27/11/17.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import RxSwift

protocol PFeaturedRepository {
    func moviesNowPlaying(region: String) -> Observable<[Movie]>
    func showsOnTheAir() -> Observable<[Show]>
}
