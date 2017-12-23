//
//  Filmografy.swift
//  TMDbCore
//
//  Created by Administrador on 27/11/17.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation

struct Filmografy: Decodable
{
    struct Work: Decodable {
 
        let identifier: Int64
        let mediaType: MediaTypeDetail
        let movieTitle: String?
        let showName: String?
        let posterPath: String?
        
        enum MediaTypeDetail: String, Decodable {
            case movie
            case tv
            case person
        }
        private enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case mediaType = "media_type"
            case movieTitle = "original_title"
            case showName = "original_name"
            case posterPath = "poster_path"
        }
        
    }
    
    let works: [Work]
    
    private enum CodingKeys: String, CodingKey {
        case works = "cast"
    }
}
