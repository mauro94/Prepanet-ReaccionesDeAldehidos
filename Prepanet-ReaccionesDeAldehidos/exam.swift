//
//  exam.swift
//  Prepanet-ReaccionesDeAldehidos
//
//  Created by Fabian Montemayor on 11/5/16.
//  Copyright © 2016 Mauro Amarante. All rights reserved.
//

import Foundation
import RealmSwift

class Exam : Object {
    dynamic var name = ""
    let questions = List<Question>()
}
