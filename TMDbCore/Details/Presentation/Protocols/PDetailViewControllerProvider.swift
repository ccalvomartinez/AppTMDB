//
//  Filw.swift
//  TMDbCore
//
//  Created by Administrador on 27/11/17.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation

protocol PDetailViewControllerProvider: class {
    func detailViewController(identifier: Int64, mediaType: MediaType) -> UIViewController
}
