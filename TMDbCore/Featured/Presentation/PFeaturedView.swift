

//
//  FEa.swift
//  TMDbCore
//
//  Created by Administrador on 27/11/17.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation

protocol PFeaturedView: class {
    var title: String? { get set }
    
    func setLoading(_ loading: Bool)
    
    func setShowsHeaderTitle(_ title: String)
    func setMoviesHeaderTitle(_ title: String)
    
    func update(with shows: [Show])
    func update(with movies: [Movie])
}
