//
//  TaggedImages.swift
//  TMDbCore
//
//  Created by Administrador on 27/11/17.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation

struct TaggedImages: Decodable
{
    struct FilmografyImage: Decodable{
        let filePath: String?
        let aspectRatio: Float?
        
        private enum CodingKeys: String, CodingKey {
            case filePath = "file_path"
            case aspectRatio = "aspect_ratio"
        }
    }
    let images: [FilmografyImage]
    
    private enum CodingKeys: String, CodingKey {
        case images = "results"
    }
}
