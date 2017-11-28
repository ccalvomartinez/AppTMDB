//
//  FeaturedPresenter.swift
//  TMDbCore
//
//  Created by Guille Gonzalez on 27/09/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import RxSwift



final class FeaturedPresenter {
	private let detailNavigator: PDetailNavigator
	weak var view: PFeaturedView?

	init(detailNavigator: PDetailNavigator) {
		self.detailNavigator = detailNavigator
	}

	func didLoad() {
		view?.title = NSLocalizedString("Featured", comment: "")
		view?.setShowsHeaderTitle(NSLocalizedString("ON TV", comment: ""))
		view?.setMoviesHeaderTitle(NSLocalizedString("IN THEATERS", comment: ""))

		addFakeContent()
	}

	func didSelect(show: Show) {
		detailNavigator.showDetail(withIdentifier: show.identifier,
		                           mediaType: .show)
	}

	func didSelect(movie: Movie) {
		detailNavigator.showDetail(withIdentifier: movie.identifier,
		                           mediaType: .movie)
	}
}

private extension FeaturedPresenter {
	func addFakeContent() {
		let shows = [
			Show(identifier: 1413,
			     title: "American Horror Story",
			     posterPath: "/gwSzP1cJL2HsBmGStN2vOg3d4Qd.jpg",
			     backdropPath: "/anDMMvgVV6pTNSxhHgiDPUjc4pH.jpg",
			     firstAirDate: "2012-01-20",
			     genreIdentifiers: [18, 9648])
		]

		view?.update(with: shows)

		let movies = [
			Movie(identifier: 330459,
			      title: "Rogue One: A Star Wars Story",
			      posterPath: "/qjiskwlV1qQzRCjpV0cL9pEMF9a.jpg",
			      backdropPath: "/tZjVVIYXACV4IIIhXeIM59ytqwS.jpg",
			      releaseDate: "2016-11-20",
			      genreIdentifiers: [28, 12, 878]),
			Movie(identifier: 297762,
			      title: "Wonder Woman",
			      posterPath: "/gfJGlDaHuWimErCr5Ql0I8x9QSy.jpg",
			      backdropPath: "/hA5oCgvgCxj5MEWcLpjXXTwEANF.jpg",
			      releaseDate: "2017-05-20",
			      genreIdentifiers: [28, 12, 14, 878]),
			Movie(identifier: 324852,
			      title: "Despicable Me 3",
			      posterPath: "/5qcUGqWoWhEsoQwNUrtf3y3fcWn.jpg",
			      backdropPath: "/7YoKt3hzTg38iPlpCumqcriaNTV.jpg",
			      releaseDate: "2017-08-20",
			      genreIdentifiers: [12, 16, 35]),
		]

		view?.update(with: movies)
	}
}
