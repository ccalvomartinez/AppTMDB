//
//  DetailHeader+PersonDetail.swift
//  TMDbCore
//
//  Created by Administrador on 27/11/17.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation

extension DetailHeader {
    init(person: PersonDetail, dateFormatter: DateFormatter) {
        title = person.name
        posterPath = person.profilePath
        backdropPath = person.taggedImages?.images.filter({image in image.aspectRatio == 16/9}).first?.filePath
        if let bornDate = person.bornDate,
            let formattedDate = dateFormatter.date(from: bornDate){
            
            metadata = "Born \(dateFormatter.string(from: formattedDate))"
        } else {
            metadata = ""
        }
    }
}

