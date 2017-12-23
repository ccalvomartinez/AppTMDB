//
//  DetailHeader+ShowDetail.swift
//  TMDbCore
//
//  Created by Administrador on 27/11/17.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation

extension DetailHeader {
    init(show: ShowDetail, dateFormatter: DateFormatter) {
        title = show.name
        posterPath = show.posterPath
        backdropPath = show.backdropPath
        
        let releaseDate = show.releaseDate.flatMap { dateFormatter.date(from: $0)}
        let year = (releaseDate?.year).map { String($0) }
        let duration = "\(show.numberOfSeasons) seassons."
        
        metadata = [year, duration].flatMap { $0 }.joined(separator: " - ")
    }
}
