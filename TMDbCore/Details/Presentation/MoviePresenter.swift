//
//  MoviePresenter.swift
//  TMDbCore
//
//  Created by Guille Gonzalez on 08/10/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import RxSwift

final class MoviePresenter: PDetailPresenter {
    private let repository: PMovieRepositoryProtocol
    private let dateFormatter: DateFormatter
    private let detailNavigator: PDetailNavigator
    
    private let identifier: Int64
    private let disposeBag = DisposeBag()
    
    weak var view: PDetailView?
    
    init(repository: PMovieRepositoryProtocol,
         dateFormatter: DateFormatter,
         detailNavigator: PDetailNavigator,
         identifier: Int64) {
        self.repository = repository
        self.dateFormatter = dateFormatter
        self.identifier = identifier
        self.detailNavigator = detailNavigator
    }
    
    func didLoad() {
        view?.setLoading(true)
        
        repository.movie(withIdentifier: identifier)
            .map { [weak self] movie in
                self?.detailSections(for: movie) ?? []
            }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] sections in
                self?.view?.update(with: sections)
            }, onDisposed: { [weak self] in
                self?.view?.setLoading(false)
            })
            .disposed(by: disposeBag)
    }
    
    func didSelect(item: PosterStripItem) {
        detailNavigator.showDetail(withIdentifier: item.identifier,
                                   mediaType: item.mediaType)
    }
    
    private func detailSections(for movie: MovieDetail) -> [DetailSection] {
		var detailSections: [DetailSection] = [
			.header(DetailHeader(movie: movie, dateFormatter: dateFormatter))
		]

		if let overview = movie.overview, !overview.isEmpty {
			detailSections.append(.about(title: "Overview", detail: overview))
		}

		let items = movie.credits?.cast.map { PosterStripItem(castMember: $0) }

		if let items = items, items.count > 0 {
			detailSections.append(.posterStrip(title: "Cast", items: items))
		}

        return detailSections
    }
}
