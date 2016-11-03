//
//  GameScene.swift
//  Prepanet-ReaccionesDeAldehidos
//
//  Created by Mauro Amarante on 11/1/16.
//  Copyright © 2016 Mauro Amarante. All rights reserved.
//

import SpriteKit
import RealmSwift

extension Array {
	//Randomizes the order of an array's elements.
	mutating func shuffle() {
		for _ in 0..<10 {
			sort { (_,_) in arc4random() < arc4random() }
		}
	}
}

let sprite1Category = 0x1 << 0
let sprite2Category = 0x1 << 1

class GameScene: SKScene, SKPhysicsContactDelegate {
	//game variables
	let player = SKSpriteNode(imageNamed: "player")
	let bgImage = SKSpriteNode(imageNamed: "gameBackground")
	var lbPointsTitle: SKLabelNode = SKLabelNode(text: "Puntos:")
	var lbPoints: SKLabelNode = SKLabelNode(text: "0")
	var lbComponent: SKLabelNode = SKLabelNode(text: "")
	var points: Int = 0
	var gameOver: Bool = false
	var componentCount: Int! = 0
	
	//data variables
	var data: Results<gameData>!
	var compounds: Array<chemicalCompound>!
	var components: Array<chemicalComponent>!
	
	override func didMove(to view: SKView) {
		//define contact delegate
		self.physicsWorld.contactDelegate = self
		
		//define player position
		player.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.17)
		
		//background
		bgImage.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
		self.addChild(bgImage)
		
		//labels
		setLabels()
		
		//physics player
		player.physicsBody = SKPhysicsBody(rectangleOf: player.frame.size)
		player.physicsBody?.allowsRotation = false
		player.physicsBody?.affectedByGravity = false
		player.physicsBody?.categoryBitMask = UInt32(sprite1Category)
		player.physicsBody?.contactTestBitMask = UInt32(sprite2Category)
		player.physicsBody?.collisionBitMask = 0
		player.physicsBody?.usesPreciseCollisionDetection = true
		player.physicsBody?.isDynamic = true
		
		//add player to scene
		self.addChild(player)
		
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
		
		//run production of chemicals
		run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addChemical), SKAction.wait(forDuration: 2.0)])))
	}
	
	func setLabels() {
		lbPointsTitle.fontSize = 25
		lbPointsTitle.fontColor = UIColor.black
		lbPointsTitle.position = CGPoint(x: self.frame.width * 0.12, y: self.frame.height * 0.025)
		self.addChild(lbPointsTitle)
		
		lbPoints.fontSize = 25
		lbPoints.fontColor = UIColor.black
		lbPoints.position = CGPoint(x: self.frame.width * 0.25, y: self.frame.height * 0.025)
		self.addChild(lbPoints)
		
		lbComponent.fontSize = 20
		lbComponent.fontColor = UIColor.black
		lbComponent.position = CGPoint(x: self.frame.width * 0.7, y: self.frame.height * 0.025)
		lbComponent.text = "DFDFD"
		self.addChild(lbComponent)
	}
	
	func random() -> CGFloat {
		return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
	}
 
	func random(min: CGFloat, max: CGFloat) -> CGFloat {
		return random() * (max - min) + min
	}
	
	func addChemical() {
		//create sprite
		let chemical = SKSpriteNode(imageNamed: components[componentCount].image)
		chemical.name = "chemical"
		
		//define y axis location
		let xPos = random(min: chemical.size.width/2, max: size.width - chemical.size.width/2)
		
		//position the chemical off screen on top
		chemical.position = CGPoint(x: xPos, y: self.frame.height + chemical.size.height/2)
		
		//increase index
		componentCount = (componentCount + 1)%components.count
		
		//define speed of chemical
		let speed = random(min: CGFloat(5.0), max: CGFloat(7.0))
		
		//define actions
		let actionMove = SKAction.move(to: CGPoint(x: xPos, y: -chemical.size.width/2), duration: TimeInterval(speed))
		let actionMoveDone = SKAction.removeFromParent()
		chemical.run(SKAction.sequence([actionMove, actionMoveDone]))
		
		//create physics
		chemical.physicsBody = SKPhysicsBody(rectangleOf: chemical.frame.size)
		chemical.physicsBody?.isDynamic = true
		chemical.physicsBody?.affectedByGravity = false
		chemical.physicsBody?.allowsRotation = false
		chemical.physicsBody?.categoryBitMask = UInt32(sprite2Category)
		chemical.physicsBody?.contactTestBitMask = UInt32(sprite1Category)
		chemical.physicsBody?.usesPreciseCollisionDetection = true
		chemical.physicsBody?.collisionBitMask = 0
		
		//add chemical to the scene
		self.addChild(chemical)
	}
	
	override func update(_ currentTime: CFTimeInterval) {
		if !gameOver {
			if player.position.y <= 0 {
				//endGame()
			}
			enumerateChildNodes(withName: "chemical") {
				chemical, _ in
				if chemical.position.y <= self.frame.height * 0.12 {
					chemical.removeFromParent()
				}
			}
		}
	}
	
	func didBegin(_ contact: SKPhysicsContact) {
		let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
		switch(contactMask) {
		case UInt32(sprite1Category) | UInt32(sprite2Category):
			let secondNode = contact.bodyB.node
			secondNode?.removeFromParent()
			//check if obtained chemical is part of compound
			lbPoints.text = "\(Int(lbPoints.text!)! + 1)"
			//endGame()
		default:
			return
		}
	}
}
