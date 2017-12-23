//
//  PosterStripItem+Work.swift
//  TMDbCore
//
//  Created by Administrador on 27/11/17.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation

extension PosterStripItem {
    init(work: Filmografy.Work) {
        identifier = work.identifier
        switch work.mediaType {
        case .movie:
            mediaType = .movie
        case .person:
            mediaType = .person
        case .tv:
            mediaType = .show
        }
        title = work.movieTitle ?? work.showName ?? ""
        metadata = String(describing: work.mediaType).uppercased()
        posterPath = work.posterPath
    }
}
