//
//  ShowPresenter.swift
//  TMDbCore
//
//  Created by Administrador on 27/11/17.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import RxSwift

final class ShowPresenter : PDetailPresenter
{
    private let identifier: Int64
    private let repository: PShowRepositoryProtocol
    private let dateFormatter: DateFormatter
    private let detailNavigator: PDetailNavigator
    
    private let disposeBag = DisposeBag()
    
    var view: PDetailView?
    
    init(identifier: Int64,
         repository: PShowRepositoryProtocol,
         dateFormatter: DateFormatter,
         detailNavigator: PDetailNavigator)
    {
        self.identifier = identifier
        self.repository = repository
        self.dateFormatter = dateFormatter
        self.detailNavigator = detailNavigator
    }
    
    func didLoad() {
        view?.setLoading(true)
        
        repository.show(withIdentifier: identifier)
            .map { [weak self] show in
                self?.detailSections(for: show) ?? []
            }
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] sections in
                    self?.view?.update(with: sections)
                },
                onDisposed: { [weak self] in
                    self?.view?.setLoading(false)
                })
            .disposed(by: disposeBag)
    }
    
    func didSelect(item: PosterStripItem) {
        detailNavigator.showDetail(withIdentifier: item.identifier,
                                   mediaType: item.mediaType)
    }
    
    private func detailSections(for show: ShowDetail) -> [DetailSection] {
        var detailSections: [DetailSection] = [
            .header(DetailHeader(show: show, dateFormatter: dateFormatter))
        ]
        
        if let overview = show.overview, !overview.isEmpty {
            detailSections.append(.about(title: "Overview", detail: overview))
        }
        
        let items = show.credits?.cast.map { PosterStripItem(castMember: $0) }
        
        if let items = items, items.count > 0 {
            detailSections.append(.posterStrip(title: "Cast", items: items))
        }
        
        return detailSections
    }
    
}
