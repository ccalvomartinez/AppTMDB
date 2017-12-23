//
//  FeaturedPresenterTest.swift
//  TMDbCoreTests
//
//  Created by Guille Gonzalez on 08/10/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import XCTest
@testable import TMDbCore

class FeaturedPresenterTest: XCTestCase {
	var sut: FeaturedPresenter!

	// Collaborators
	var detailNavigatorMock: DetailNavigatorMock!
	var featuredRepositoryMock: FeaturedRepositoryMock!
    var featureView: FeaturedViewMock!

    override func setUp() {
        super.setUp()

        detailNavigatorMock = DetailNavigatorMock()
		featuredRepositoryMock = FeaturedRepositoryMock()
        featureView = FeaturedViewMock()
		sut = FeaturedPresenter(detailNavigator: detailNavigatorMock,
		                        repository: featuredRepositoryMock)
        sut.view = featureView
        
    }
    
    func testFeaturedPresenter_didSelectShow_usesDetailNavigator() {
        // Given
		let show = Show(identifier: 42,
		                title: "Test",
		                posterPath: nil,
		                backdropPath: nil,
		                firstAirDate: nil,
		                genreIdentifiers: nil)

		// When
		sut.didSelect(show: show)

		// Then
		XCTAssertTrue(detailNavigatorMock.showDetailCalled)

		let (identifier, mediaType) = detailNavigatorMock.showDetailParameters!
		XCTAssertEqual(42, identifier)
		XCTAssertEqual(.show, mediaType)
    }
    
    func testFeaturedPresenter_didSelectMovie_usesDetailNavigator() {
        // Given
        let movie = Movie(identifier: 42,
                        title: "Test",
                        posterPath: nil,
                        backdropPath: nil,
                        releaseDate: nil,
                        genreIdentifiers: nil)
        
          // When
        sut.didSelect(movie: movie)
        
        // Then
        XCTAssertTrue(detailNavigatorMock.showDetailCalled)
        
        let (identifier, mediaType) = detailNavigatorMock.showDetailParameters!
        XCTAssertEqual(42, identifier)
        XCTAssertEqual(.show, mediaType)
    }

    func testFeaturedPresenter_didLoad_usesFeaturedView() {
        // Given
        let movie = Movie(identifier: 42,
                          title: "Test",
                          posterPath: nil,
                          backdropPath: nil,
                          releaseDate: nil,
                          genreIdentifiers: nil)
        
        let show = Show(identifier: 43,
                        title: "Test",
                        posterPath: nil,
                        backdropPath: nil,
                        firstAirDate: nil,
                        genreIdentifiers: nil)
        
        featuredRepositoryMock.setResults(movies: [movie], shows: [show])
        
        // When
        sut.didLoad()
     
        // Then
        XCTAssertEqual(sut.view!.title, NSLocalizedString("Featured", comment: ""))
       
        XCTAssertTrue(featureView.setMoviesHeaderTitleCalled)
        XCTAssertNotNil(featureView.setMoviesHeaderTitleParameters)
        XCTAssertEqual(featureView.setMoviesHeaderTitleParameters!, NSLocalizedString("IN THEATERS", comment: ""))
        
        XCTAssertTrue(featureView.setShowsHeaderTitleCalled)
        XCTAssertNotNil(featureView.setShowsHeaderTitleParameters)
        XCTAssertEqual(featureView.setShowsHeaderTitleParameters!, NSLocalizedString("ON TV", comment: ""))
        
        XCTAssertTrue(featureView.setLoadingCalled)
        XCTAssertEqual(featureView.setLoadingParameters.count, 2)
        XCTAssertEqual(featureView.setLoadingParameters.first, true)
        XCTAssertEqual(featureView.setLoadingParameters.last, false)
        
        XCTAssertTrue(featureView.updateWithMoviesCalled)
        XCTAssertNotNil(featureView.updateMoviesParameters)
        XCTAssertEqual(featureView.updateMoviesParameters?.count, 1)
        XCTAssertEqual(featureView.updateMoviesParameters!.first?.identifier, movie.identifier)
        
        
        XCTAssertTrue(featureView.updateWithShowsCalled)
        XCTAssertNotNil(featureView.updateShowsParameters)
         XCTAssertEqual(featureView.updateShowsParameters?.count, 1)
        XCTAssertEqual(featureView.updateShowsParameters!.first?.identifier, show.identifier)
        
}
}
