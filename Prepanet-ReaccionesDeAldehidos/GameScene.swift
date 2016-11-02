//
//  GameScene.swift
//  Prepanet-ReaccionesDeAldehidos
//
//  Created by Mauro Amarante on 11/1/16.
//  Copyright © 2016 Mauro Amarante. All rights reserved.
//

import SpriteKit
import GameplayKit
import RealmSwift

extension Array {
	/** Randomizes the order of an array's elements. */
	mutating func shuffle() {
		for _ in 0..<10 {
			sort { (_,_) in arc4random() < arc4random() }
		}
	}
}

struct PhysicsCategory {
	static let None      : UInt32 = 0
	static let All       : UInt32 = UInt32.max
	static let Player   : UInt32 = 0b1
	static let Chemical: UInt32 = 0b10
}

class GameScene: SKScene, SKPhysicsContactDelegate {
	//variables
	let player = SKSpriteNode(imageNamed: "player")
	var componentCount: Int! = 0
	var data: Results<gameData>!
	var compounds: Array<chemicalCompound>!
	var components: Array<chemicalComponent>!
	
	override func didMove(to view: SKView) {
		//background
		let bgImage = SKSpriteNode(imageNamed: "gameBackground")
		bgImage.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
		self.addChild(bgImage)
		
		//get game data
		let realm = try! Realm()
		data = realm.objects(gameData.self)
		
		//get chemical compunds
		let result = data.first?.chemicalCompunds
		compounds = Array(result!)
		compounds.shuffle()
		
		//get chemical components
		let result2 = data.first?.chemicalComponents
		components = Array(result2!)
		components.shuffle()
		
		//define background
		backgroundColor = SKColor.white
		
		//define player position
		player.position = CGPoint(x: size.width * 0.5, y: size.height * 0.17)
		
		//add player to scene
		addChild(player)
		
		//define no gravity and delegate of collisions
		physicsWorld.gravity = CGVector(dx: 0, dy: 0)
		physicsWorld.contactDelegate = self
		
		run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addChemical), SKAction.wait(forDuration: 1.0)])))
	}
	
	func addChemical() {
		//create sprite
		let chemical = SKSpriteNode(imageNamed: components[componentCount].image)
		
		//create physics rectangle/body
		chemical.physicsBody = SKPhysicsBody(rectangleOf: chemical.size)
		//physics engine will not control the movement
		chemical.physicsBody?.isDynamic = true
		//define physics category
		chemical.physicsBody?.categoryBitMask = PhysicsCategory.Chemical
		//define collision object
		chemical.physicsBody?.contactTestBitMask = PhysicsCategory.Player
		//VER WTF
		chemical.physicsBody?.collisionBitMask = PhysicsCategory.None
		
		//define y axis location
		let xPos = random(min: chemical.size.width/2, max: size.width - chemical.size.width/2)
		
		//position the chemical off screen on top
		chemical.position = CGPoint(x: xPos, y: size.height + chemical.size.height/2)
		
		//add chemical to the scene
		addChild(chemical)
		
		//define speed of chemical
		let speed = random(min: CGFloat(5.0), max: CGFloat(7.0))
		
		//define actions
		let actionMove = SKAction.move(to: CGPoint(x: xPos, y: -chemical.size.width/2), duration: TimeInterval(speed))
		let actionMoveDone = SKAction.removeFromParent()
		chemical.run(SKAction.sequence([actionMove, actionMoveDone]))
		
	}
	
	func random() -> CGFloat {
		return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
	}
 
	func random(min: CGFloat, max: CGFloat) -> CGFloat {
		return random() * (max - min) + min
	}
	
}
