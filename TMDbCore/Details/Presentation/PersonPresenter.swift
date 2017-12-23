//
//  PersonPresenter.swift
//  TMDbCore
//
//  Created by Administrador on 27/11/17.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import RxSwift

final class PersonPresenter: PDetailPresenter
{
    private let identifier: Int64
    private let repository: PPersonRepositoryProtocol
    private let dateFormatter: DateFormatter
      private let detailNavigator: PDetailNavigator
    
    private let disposeBag = DisposeBag()
    
    var view: PDetailView?
    
    init(identifier: Int64,
         repository: PPersonRepositoryProtocol,
         detailNavigator: PDetailNavigator,
         dateFormatter: DateFormatter)
    {
        self.identifier = identifier
        self.repository = repository
        self.dateFormatter = dateFormatter
        self.detailNavigator = detailNavigator
    }
    
    func didLoad() {
        view?.setLoading(true)
        
        repository.person(withIdentifier: identifier)
            .map { [weak self] person in
                self?.detailSections(for: person) ?? []
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
    
    private func detailSections(for person: PersonDetail) -> [DetailSection] {
        var detailSections: [DetailSection] = [
            .header(DetailHeader(person: person, dateFormatter: dateFormatter))
        ]
        
        if let biography = person.biography, !biography.isEmpty {
            detailSections.append(.about(title: NSLocalizedString("About", comment: ""), detail: biography))
        }
        
        let items = person.filmografy?.works.map { PosterStripItem(work: $0) }
        
        if let items = items, items.count > 0 {
            detailSections.append(.posterStrip(title: "Filmografy", items: items))
        }
        
        return detailSections
    }
}
