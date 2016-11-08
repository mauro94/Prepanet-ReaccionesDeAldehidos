//
//  gameData.swift
//  Prepanet-ReaccionesDeAldehidos
//
//  Created by Mauro Amarante on 11/1/16.
//  Copyright © 2016 Mauro Amarante. All rights reserved.
//

import Foundation
import RealmSwift

class gameData: Object {
	dynamic var maxPoints = 0
	dynamic var rulesSeen = false
	var chemicalComponents = List<chemicalComponent>()
	var chemicalCompunds = List<chemicalCompound>()
}
