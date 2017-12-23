//
//  PersonDetail.swift
//  TMDbCore
//
//  Created by Administrador on 27/11/17.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation

struct PersonDetail: Decodable {
    let identifier: Int64
    let biography: String?
    let profilePath: String?
    let bornDate: String?
    let name: String
    let knownFor: String?
    let taggedImages: TaggedImages?
    let filmografy: Filmografy?
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case biography
        case bornDate = "birthday"
        case taggedImages = "tagged_images"
        case name
        case profilePath = "profile_path"
        case knownFor = "known_for"
        case filmografy = "combined_credits"
    }
}
