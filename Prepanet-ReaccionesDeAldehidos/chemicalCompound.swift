//
//  chemicalCompound.swift
//  Prepanet-ReaccionesDeAldehidos
//
//  Created by Mauro Amarante on 11/1/16.
//  Copyright © 2016 Mauro Amarante. All rights reserved.
//

import Foundation
import RealmSwift

class chemicalCompound: Object {
	dynamic var name = ""
	dynamic var level = 0
	var chemicalComponents = List<chemicalComponent>()
}
