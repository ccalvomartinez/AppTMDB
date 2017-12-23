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
    private let repository: PFeaturedRepository
    private let disposeBag = DisposeBag()
    
	weak var view: PFeaturedView?

    init(detailNavigator: PDetailNavigator,
         repository: PFeaturedRepository) {
		self.detailNavigator = detailNavigator
        self.repository = repository
	}

	func didLoad() {
		view?.title = NSLocalizedString("Featured", comment: "")
		view?.setShowsHeaderTitle(NSLocalizedString("ON TV", comment: ""))
		view?.setMoviesHeaderTitle(NSLocalizedString("IN THEATERS", comment: ""))

		loadContents()
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
    func loadContents() {
        view?.setLoading(true)
        
        let showsOnTheAir = repository.showsOnTheAir()
            .map { $0.prefix(3) }
        let moviesNowPlaying = repository.moviesNowPlaying(region: Locale.current.regionCode!)
            .map { $0.prefix(3) }
        
        Observable.combineLatest(showsOnTheAir, moviesNowPlaying) { shows, movies in
            return (shows, movies)
        }
        .observeOn(MainScheduler.instance)
        .subscribe(
            onNext: { [weak self] shows, movies in
                guard let `self` = self else {
                    return
                }
                self.view?.update(with: Array(shows))
                self.view?.update(with: Array(movies))
            },
            onDisposed: { [weak self] in
                self?.view?.setLoading(false)
        })
        .disposed(by: disposeBag)
    }
}
