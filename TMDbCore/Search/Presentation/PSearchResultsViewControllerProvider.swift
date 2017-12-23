//
//  SearchResultsViewControllerProvider.swift
//  TMDbCore
//
//  Created by Administrador on 27/11/17.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation

protocol PSearchResultsViewControllerProvider: class {
    func searchResultsViewController() -> SearchResultsViewController
}
