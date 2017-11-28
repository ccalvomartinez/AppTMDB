//
//  PDetailView.swift
//  TMDbCore
//
//  Created by Administrador on 23/11/17.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation

protocol PDetailView: class {
    func setLoading(_ loading: Bool)
    func update(with sections: [DetailSection])
}
