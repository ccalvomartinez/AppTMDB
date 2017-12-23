//
//  DetailPresenter.swift
//  TMDbCore
//
//  Created by Guille Gonzalez on 30/09/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation

protocol PDetailPresenter: class {
	weak var view: PDetailView? { get set }

	func didLoad()
	func didSelect(item: PosterStripItem)
}
