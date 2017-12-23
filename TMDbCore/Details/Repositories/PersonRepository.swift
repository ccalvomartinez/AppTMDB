//
//  PersonRepository.swift
//  TMDbCore
//
//  Created by Administrador on 27/11/17.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import RxSwift

final class PersonRepository: PPersonRepositoryProtocol
{
    private let webService: WebService
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func person(withIdentifier identifier: Int64) -> Observable<PersonDetail> {
         return webService.load(PersonDetail.self, from: .person(identifier: identifier))
    }
}
