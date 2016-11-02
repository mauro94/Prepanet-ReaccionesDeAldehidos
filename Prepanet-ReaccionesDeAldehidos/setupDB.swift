//
//  setupDB.swift
//  Prepanet-ReaccionesDeAldehidos
//
//  Created by Mauro Amarante on 11/1/16.
//  Copyright © 2016 Mauro Amarante. All rights reserved.
//

import Foundation
import RealmSwift

struct ChemComponentSruct {
	var name: String!
	var image: String!
	var count: Int!
}

struct ChemCompoundtSruct {
	var name: String!
	var level: Int!
	var chemComponent: [ChemComponentSruct]!
}

class setupDB {
	
	init() {
		//database
		let gameData = setupGameData()
		
		let realm = try! Realm()
		
		//create database
		try! realm.write {
			realm.add(gameData)
		}
	}
	
	func setupGameData() ->  gameData{
		//data
		//chemical components
		let carbon = ChemComponentSruct(name: "Hidrógeno", image: "hydrogen", count: 0)
		let hydrogen = ChemComponentSruct(name: "Hidrógeno", image: "hydrogen", count: 0)
		let oxygen = ChemComponentSruct(name: "Oxígeno", image: "oxygen", count: 0)
		let simpleLink = ChemComponentSruct(name: "Enlace simple", image: "simpleLink", count: 0)
		let doubleLink = ChemComponentSruct(name: "Doble enlace", image: "doubleLink", count: 0)
		let tripleLink = ChemComponentSruct(name: "Triple enlace", image: "tripleLink", count: 0)
		let benzene = ChemComponentSruct(name: "Benceno", image: "benzene", count: 0)
		let furan = ChemComponentSruct(name: "Furano", image: "furan", count: 0)
		let cyclohexane = ChemComponentSruct(name: "ciclohexano", image: "cyclohexane", count: 0)
		
		var chemComponents = [ChemComponentSruct]()
		chemComponents.append(carbon)
		chemComponents.append(hydrogen)
		chemComponents.append(oxygen)
		chemComponents.append(simpleLink)
		chemComponents.append(doubleLink)
		chemComponents.append(tripleLink)
		chemComponents.append(benzene)
		chemComponents.append(furan)
		chemComponents.append(cyclohexane)

		//chemical compounds
		var chemCompounds = [ChemCompoundtSruct]()
		chemCompounds.append(ChemCompoundtSruct(name: "Metanal", level: 1,
		                                        chemComponent: [changeComponentCount(component: carbon, newValue: 1),
		                                                        changeComponentCount(component: hydrogen, newValue: 2),
		                                                        changeComponentCount(component: oxygen, newValue: 1),
		                                                        changeComponentCount(component: simpleLink, newValue: 2),
		                                                        changeComponentCount(component: doubleLink, newValue: 1)]))
		chemCompounds.append(ChemCompoundtSruct(name: "Etanal/Acetaldehído", level: 1,
												chemComponent: [changeComponentCount(component: carbon, newValue: 2),
												                changeComponentCount(component: hydrogen, newValue: 4),
												                changeComponentCount(component: oxygen, newValue: 1),
												                changeComponentCount(component: simpleLink, newValue: 5),
												                changeComponentCount(component: doubleLink, newValue: 1)]))
		chemCompounds.append(ChemCompoundtSruct(name: "Propanal", level: 1,
		                                        chemComponent: [changeComponentCount(component: carbon, newValue: 3),
		                                                        changeComponentCount(component: hydrogen, newValue: 6),
		                                                        changeComponentCount(component: oxygen, newValue: 1),
		                                                        changeComponentCount(component: simpleLink, newValue: 8),
		                                                        changeComponentCount(component: doubleLink, newValue: 1)]))
		chemCompounds.append(ChemCompoundtSruct(name: "Butanal", level: 1,
		                                        chemComponent: [changeComponentCount(component: carbon, newValue: 4),
		                                                        changeComponentCount(component: hydrogen, newValue: 8),
		                                                        changeComponentCount(component: oxygen, newValue: 1),
		                                                        changeComponentCount(component: simpleLink, newValue:11),
		                                                        changeComponentCount(component: doubleLink, newValue: 1)]))
		chemCompounds.append(ChemCompoundtSruct(name: "Prop-2-enal/Acroleína", level: 2,
		                                        chemComponent: [changeComponentCount(component: carbon, newValue: 3),
		                                                        changeComponentCount(component: hydrogen, newValue: 4),
		                                                        changeComponentCount(component: oxygen, newValue: 1),
		                                                        changeComponentCount(component: simpleLink, newValue: 5),
		                                                        changeComponentCount(component: doubleLink, newValue: 2)]))
		chemCompounds.append(ChemCompoundtSruct(name: "Benzaldehído", level: 2,
		                                        chemComponent: [changeComponentCount(component: benzene, newValue: 1),
		                                                        changeComponentCount(component: carbon, newValue: 1),
		                                                        changeComponentCount(component: hydrogen, newValue: 1),
		                                                        changeComponentCount(component: oxygen, newValue: 1),
		                                                        changeComponentCount(component: simpleLink, newValue: 2),
		                                                        changeComponentCount(component: doubleLink, newValue: 1)]))

		chemCompounds.append(ChemCompoundtSruct(name: "Ciclohexanocarbaldehído", level: 2,
		                                        chemComponent: [changeComponentCount(component: cyclohexane, newValue: 1),
		                                                        changeComponentCount(component: carbon, newValue: 1),
		                                                        changeComponentCount(component: hydrogen, newValue: 1),
		                                                        changeComponentCount(component: oxygen, newValue: 1),
		                                                        changeComponentCount(component: simpleLink, newValue: 2),
		                                                        changeComponentCount(component: doubleLink, newValue: 1)]))
		chemCompounds.append(ChemCompoundtSruct(name: "2-furaldehído/Furfural", level: 3,
		                                        chemComponent: [changeComponentCount(component: furan, newValue: 1),
		                                                        changeComponentCount(component: carbon, newValue: 1),
		                                                        changeComponentCount(component: hydrogen, newValue: 1),
		                                                        changeComponentCount(component: oxygen, newValue: 1),
		                                                        changeComponentCount(component: simpleLink, newValue: 2),
		                                                        changeComponentCount(component: doubleLink, newValue: 1)]))
		chemCompounds.append(ChemCompoundtSruct(name: "4,4-Dimetilbutanal", level: 3,
		                                        chemComponent: [changeComponentCount(component: carbon, newValue: 6),
		                                                        changeComponentCount(component: hydrogen, newValue: 12),
		                                                        changeComponentCount(component: oxygen, newValue: 1),
		                                                        changeComponentCount(component: simpleLink, newValue: 17),
		                                                        changeComponentCount(component: doubleLink, newValue: 1)]))
		chemCompounds.append(ChemCompoundtSruct(name: "Pentanodial", level: 3,
		                                        chemComponent: [changeComponentCount(component: carbon, newValue: 5),
		                                                        changeComponentCount(component: hydrogen, newValue: 8),
		                                                        changeComponentCount(component: oxygen, newValue: 2),
		                                                        changeComponentCount(component: simpleLink, newValue: 12),
		                                                        changeComponentCount(component: doubleLink, newValue: 2)]))
		
		//db instance
		let data = gameData()
		
		//add chemical components
		for i in 0...chemComponents.count-1 {
			//create chemical component object instance
			let chemComp = chemicalComponent()
			chemComp.name = chemComponents[i].name
			chemComp.image = chemComponents[i].image
			chemComp.count = chemComponents[i].count
			
			//append to db
			data.chemicalComponents.append(chemComp)
		}
		
		//add chemical compunds
		for i in 0...chemCompounds.count-1 {
			//create chemical component object instance
			let chemComp = chemicalCompound()
			chemComp.name = chemCompounds[i].name
			chemComp.level = chemCompounds[i].level
			//create chemical component object instance
			for j in 0...chemCompounds[i].chemComponent.count-1 {
				let component = chemicalComponent()
				component.name = chemCompounds[i].chemComponent[j].name
				component.image = chemCompounds[i].chemComponent[j].image
				component.count = chemCompounds[i].chemComponent[j].count
				chemComp.chemicalComponents.append(component)
			}
			
			//append to db
			data.chemicalCompunds.append(chemComp)
		}
		
		return data
	}
	
	func changeComponentCount(component: ChemComponentSruct, newValue: Int) -> ChemComponentSruct {
		return ChemComponentSruct(name: component.name, image: component.image, count: newValue)
	}
}
