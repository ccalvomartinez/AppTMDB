//
//  FeaturedVieewMock.swift
//  TMDbCoreTests
//
//  Created by Administrador on 27/11/17.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

@testable import TMDbCore


final class FeaturedViewMock: PFeaturedView
{
    var title: String?
    var setLoadingCalled = false
    var setLoadingParameters: [Bool] = []
    var setShowsHeaderTitleCalled = false
    var setShowsHeaderTitleParameters: String?
    var setMoviesHeaderTitleCalled = false
    var setMoviesHeaderTitleParameters: String?
    var updateWithShowsCalled = false
    var updateShowsParameters: [Show]?
    var updateWithMoviesCalled = false
    var updateMoviesParameters: [Movie]?
    
    func setLoading(_ loading: Bool) {
        setLoadingCalled = true
        setLoadingParameters.append(loading)
    }
    
    func setShowsHeaderTitle(_ title: String) {
        setShowsHeaderTitleCalled = true
        setShowsHeaderTitleParameters = title
    }
    
    func setMoviesHeaderTitle(_ title: String) {
        setMoviesHeaderTitleCalled = true
        setMoviesHeaderTitleParameters = title
    }
    
    func update(with shows: [Show]) {
        updateWithShowsCalled = true
        updateShowsParameters = shows
    }
    
    func update(with movies: [Movie]) {
        updateWithMoviesCalled = true
        updateMoviesParameters = movies
    }
}
