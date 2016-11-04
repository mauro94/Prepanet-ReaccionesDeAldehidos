//
//  GameScene.swift
//  Prepanet-ReaccionesDeAldehidos
//
//  Created by Mauro Amarante on 11/1/16.
//  Copyright © 2016 Mauro Amarante. All rights reserved.
//

import SpriteKit
import RealmSwift
import CoreMotion
import Foundation

//Randomizes the order of an array's elements.
extension Array {
	mutating func shuffle() {
		for _ in 0..<10 {
			sort { (_,_) in arc4random() < arc4random() }
		}
	}
}

//Resize image
extension UIImage {
	func imageResize (sizeChange:CGSize)-> UIImage{
		
		let hasAlpha = true
		let scale: CGFloat = 0.0 // Use scale factor of main screen
		
		UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
		self.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
		
		let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
		return scaledImage!
	}
}

class GameScene: SKScene, SKPhysicsContactDelegate {
	//game variables
	var player: SKSpriteNode!
	let playerTexture1 = SKTexture(imageNamed: "player")
	let playerTexture2 = SKTexture(imageNamed: "player2")
	let playerTexture3 = SKTexture(imageNamed: "player3")
	let score = SKSpriteNode(imageNamed: "score")
	let bgImage = SKSpriteNode(imageNamed: "gameBackground")
	let pauseButton = SKSpriteNode(imageNamed: "pauseButton")
	var pauseImg = SKSpriteNode(imageNamed: "pause")
	let scoreFill = SKSpriteNode(imageNamed: "scoreFill")
	var lbPointsTitle: SKLabelNode = SKLabelNode(text: "Puntos:")
	var lbComponentTitle: SKLabelNode = SKLabelNode(text: "Compuesto:")
	var lbComponent: SKLabelNode = SKLabelNode(text: "")
	var lbPoints: SKLabelNode = SKLabelNode(text: "0")
	var points: Int = 0
	var gameOver: Bool = false
	var componentCount: Int! = 0
	var compundCount: Int! = 0
	let sprite1Category = 0x1 << 0
	let sprite2Category = 0x1 << 1
	let sprite3Category = 0x1 << 2
	var solutionCompund = [String: Int]()
	var totalSolutionCount: Int = 0
	var obtainedChemicals: Int = 0
	var isGamePaused: Bool = false
	
	//motion variables
	var motionManager: CMMotionManager!
	
	//data variables
	var data: Results<gameData>!
	var compounds: Array<chemicalCompound>!
	var components: Array<chemicalComponent>!
	
	override func didMove(to view: SKView) {
		//define contact delegate
		self.physicsWorld.contactDelegate = self
		
		//activate motion deection
		motionManager = CMMotionManager()
		motionManager.startAccelerometerUpdates()
		
		//define player
		let animatePlayer = SKAction.sequence([
			SKAction.wait(forDuration: 1, withRange: 1),
			SKAction.animate(with: [playerTexture2, playerTexture3], timePerFrame: 1)
			])
		
		let changePlayer = SKAction.repeatForever(animatePlayer)
		
		player = SKSpriteNode(texture: playerTexture1)
		
		//define player position
		player.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.2)
		
		player.run(changePlayer)
		
		//background
		bgImage.size = self.frame.size
		bgImage.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
		bgImage.zPosition = -1
		self.addChild(bgImage)
		
		//pause button
		pauseButton.size = CGSize(width: pauseButton.frame.size.width*1.5 , height: pauseButton.frame.size.height*1.5)
		pauseButton.position = CGPoint(x: self.frame.width * 0.08, y: self.frame.height * 0.92)
		self.addChild(pauseButton)
		
		//score
		score.position = CGPoint(x: self.frame.width * 0.89, y: self.frame.height * 0.06)
		score.size = CGSize(width: self.frame.size.width * 0.2, height: self.frame.size.height * 0.12)
		score.zPosition = 1
		self.addChild(score)
		
		//scorefill
		scoreFill.position = CGPoint(x: self.frame.width * 0.86, y: self.frame.height * 0.06)
		scoreFill.size = CGSize(width: score.frame.size.width*0.8, height: 0)
		self.addChild(scoreFill)
		
		//defines bounds of player
		let collisionFrame = frame.insetBy(dx: 0, dy: -self.size.height)
		physicsBody = SKPhysicsBody(edgeLoopFrom: collisionFrame)
		physicsBody?.categoryBitMask = UInt32(sprite3Category)
		
		//physics player
		player.physicsBody = SKPhysicsBody(rectangleOf: player.frame.size)
		player.physicsBody?.allowsRotation = false
		player.physicsBody?.affectedByGravity = false
		player.physicsBody?.categoryBitMask = UInt32(sprite1Category)
		player.physicsBody?.contactTestBitMask = UInt32(sprite2Category)
		player.physicsBody?.collisionBitMask = UInt32(sprite3Category)
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
		
		//labels
		setLabels()
		
		//define solution
		for i in compounds[compundCount].chemicalComponents {
			solutionCompund[i.image] = i.count
			totalSolutionCount += i.count
		}
		
		//run production of chemicals
		run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addChemical), SKAction.wait(forDuration: 1.0)])))
	}
	
	func setLabels() {
		var loc: CGFloat!
		
		lbComponentTitle.fontSize = 17
		lbComponentTitle.fontColor = UIColor.black
		loc = lbComponentTitle.frame.size.width/2 + 5
		lbComponentTitle.position = CGPoint(x: loc, y: self.frame.height * 0.07)
		self.addChild(lbComponentTitle)
		
		lbComponent.fontSize = 17
		lbComponent.fontColor = UIColor.black
		lbComponent.text = "\(compounds[compundCount].name)"
		loc = lbComponentTitle.frame.size.width + lbComponent.frame.size.width/2 + 10
		lbComponent.position = CGPoint(x: loc, y: self.frame.height * 0.07)
		self.addChild(lbComponent)
		
		lbPointsTitle.fontSize = 17
		lbPointsTitle.fontColor = UIColor.black
		loc = lbPointsTitle.frame.size.width/2 + 5
		lbPointsTitle.position = CGPoint(x: loc, y: self.frame.height * 0.07  - lbComponentTitle.frame.size.height - 10)
		self.addChild(lbPointsTitle)
		
		lbPoints.fontSize = 17
		lbPoints.fontColor = UIColor.black
		loc = lbPointsTitle.frame.size.width + lbPoints.frame.size.width/2 + 10
		lbPoints.position = CGPoint(x: loc, y: self.frame.height * 0.07  - lbComponentTitle.frame.size.height - 10)
		self.addChild(lbPoints)
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
		//print(components[componentCount].image)
		chemical.name = "chemical"
		
		//define y axis location
		let xPos = random(min: chemical.size.width/2, max: size.width - chemical.size.width/2)
		
		//position the chemical off screen on top
		chemical.position = CGPoint(x: xPos, y: self.frame.height + chemical.size.height/2)
		
		//increase index
		componentCount = (componentCount + 1)%(components.count)
		
		if (componentCount == 8) {
			components.shuffle()
		}
		
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
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let touch = touches.first {
			let position = touch.location(in: self)
			
			if (position.x <= self.frame.size.width/2) {
				pushPlayer(val: -10)
			}
			else {
				pushPlayer(val: 10)
			}
			
			if pauseButton.contains(position) {
				if (isGamePaused) {
					unpauseGame()
				}
				else {
					pauseGame()
				}
			}
		}
	}
	
	func movePlayer() {
		//define movement amount
		if let accelerometerData = motionManager.accelerometerData {
			//apply movement
			player.physicsBody?.applyImpulse(CGVector(dx: accelerometerData.acceleration.x, dy: 0))
		}
	}
	
	func pushPlayer(val: Int) {
		let impulse =  CGVector(dx: val, dy: 0)
		player.physicsBody?.applyImpulse(impulse)
	}
	
	func pauseGame() {
		isGamePaused = true
		self.isPaused = true
		
		//diplay image
		pauseImg = SKSpriteNode(imageNamed: "pause")
		pauseImg.size = CGSize(width: pauseImg.frame.size.width*2 , height: pauseImg.frame.size.height*2)
		pauseImg.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
		self.addChild(pauseImg)
	}
	
	func unpauseGame() {
		isGamePaused = false
		self.isPaused = false
		
		//remove image
		pauseImg.removeFromParent()
	}
	
	override func update(_ currentTime: CFTimeInterval) {
		if !gameOver {
			//move player with acceleroemeter
			movePlayer()
			
			
			if player.position.y <= 0 {
				//endGame()
			}
			enumerateChildNodes(withName: "chemical") {
				chemical, _ in
				if chemical.position.y <= self.frame.height * 0.16 {
					chemical.removeFromParent()
				}
			}
		}
	}
	
	func didBegin(_ contact: SKPhysicsContact) {
		let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
		switch(contactMask) {
			case UInt32(sprite1Category) | UInt32(sprite2Category):
				//delete chemical in collision
				let secondNode = contact.bodyB.node
				secondNode?.removeFromParent()
			
				//check if collsion chemical is part of solution
				for name in solutionCompund.keys {
					if (secondNode!.description.contains(name)){
						//if components are still missing to complete compound
						if (solutionCompund[name]! > 0) {
							//reduce index
							solutionCompund[name] = solutionCompund[name]! - 1
							obtainedChemicals += 1
							//redraw score
							scoreFill.size = CGSize(width: scoreFill.frame.size.width, height: score.frame.size.height * CGFloat(obtainedChemicals) / CGFloat(totalSolutionCount))
							scoreFill.position = CGPoint(x: self.frame.width * 0.86, y: self.frame.height * 0.02 + self.frame.height * 0.04 * scoreFill.frame.size.height / score.frame.size.height)
							scoreFill.removeFromParent()
							addChild(scoreFill)
						}
					}
				}
				
				//check if limit of game was reached
				if (compundCount == compounds.count) {
					//endgame
				}
			
				//check if compound is complete
				if (totalSolutionCount == obtainedChemicals) {
					//reset score fill
					scoreFill.position = CGPoint(x: self.frame.width * 0.86, y: self.frame.height * 0.06)
					scoreFill.size = CGSize(width: score.frame.size.width*0.8, height: 0)
					scoreFill.removeFromParent()
					self.addChild(scoreFill)
					
					//add point
					lbPoints.text = "\(Int(lbPoints.text!)! + 1)"
					
					//next compound
					compundCount =  compundCount + 1
					
					totalSolutionCount = 0
					//define new solution
					for i in compounds[compundCount].chemicalComponents {
						solutionCompund[i.image] = i.count
						totalSolutionCount += i.count
					}
					
					//reset variables
					obtainedChemicals = 0
					
					//change label name
					lbComponent.text = "\(compounds[compundCount].name)"
					let loc = lbComponentTitle.frame.size.width + lbComponent.frame.size.width/2 + 10
					lbComponent.position = CGPoint(x: loc, y: self.frame.height * 0.07)
				}
			
			default:
				return
		}
	}
}
