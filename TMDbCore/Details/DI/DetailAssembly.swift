//
//  DetailAssembly.swift
//  TMDbCore
//
//  Created by Guille Gonzalez on 30/09/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation

final class DetailAssembly {
	private let imageLoadingAssembly: ImageLoadingAssembly
	private let navigationController: UINavigationController
	private let webServiceAssembly: WebServiceAssembly

	init(imageLoadingAssembly: ImageLoadingAssembly,
	     navigationController: UINavigationController,
	     webServiceAssembly: WebServiceAssembly) {
		self.imageLoadingAssembly = imageLoadingAssembly
		self.navigationController = navigationController
		self.webServiceAssembly = webServiceAssembly
	}

	func detailHeaderPresenter() -> DetailHeaderPresenter {
		return DetailHeaderPresenter(imageRepository: imageLoadingAssembly.imageRepository)
	}

	func posterStripPresenter() -> PosterStripPresenter {
		return PosterStripPresenter(imageRepository: imageLoadingAssembly.imageRepository)
	}

	func detailNavigator() -> PDetailNavigator {
		return PhoneDetailNavigator(navigationController: navigationController,
		                            viewControllerProvider: self)
	}

	func moviePresenter(identifier: Int64) -> PDetailPresenter {
		return MoviePresenter(repository: movieRepository(),
                              dateFormatter: webServiceAssembly.dateFormatter,
                              detailNavigator: detailNavigator(),
		                      identifier: identifier)
	}

    func showPresenter(identifier: Int64) -> PDetailPresenter {
        return ShowPresenter(identifier: identifier,
                             repository: showRepository(),
                             dateFormatter: webServiceAssembly.dateFormatter,
                             detailNavigator: detailNavigator())
    }
    
    func personPresenter(identifier: Int64) -> PDetailPresenter {
        return PersonPresenter(identifier: identifier,
                               repository: personRepository(),
                               detailNavigator: detailNavigator(),
                               dateFormatter: webServiceAssembly.dateFormatter)
    }
    
	func movieRepository() -> PMovieRepositoryProtocol {
		return MovieRepository(webService: webServiceAssembly.webService)
	}
    
    func showRepository() -> PShowRepositoryProtocol {
        return ShowRepository(webService: webServiceAssembly.webService)
    }
    
    func personRepository() -> PPersonRepositoryProtocol {
        return PersonRepository(webService: webServiceAssembly.webService)
    }
}

extension DetailAssembly: PDetailViewControllerProvider {
	// FIXME: Temporary!!
	private class DummyDetailPresenter: PDetailPresenter {
		var view: PDetailView?

		func didLoad() {}
		func didSelect(item: PosterStripItem) {}
	}

	func detailViewController(identifier: Int64, mediaType: MediaType) -> UIViewController {

		let presenter: PDetailPresenter

		switch mediaType {
		case .movie:
			presenter = moviePresenter(identifier: identifier)
        case .show:
            presenter = showPresenter(identifier: identifier)
        case .person:
            presenter = personPresenter(identifier: identifier)
		}
		return DetailViewController(presenter: presenter,
		                            headerPresenter: detailHeaderPresenter(),
		                            posterStripPresenter: posterStripPresenter())
	}
}
