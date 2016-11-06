//
//  question.swift
//  Prepanet-ReaccionesDeAldehidos
//
//  Created by Fabian Montemayor on 11/5/16.
//  Copyright © 2016 Mauro Amarante. All rights reserved.
//

import Foundation
import RealmSwift

class Question : Object {
    dynamic var question = ""
    dynamic var right = ""
    dynamic var wrong = ""
    dynamic var image : String? = nil
}
