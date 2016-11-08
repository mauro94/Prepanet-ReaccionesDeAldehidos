//
//  GameViewController.swift
//  Prepanet-ReaccionesDeAldehidos
//
//  Created by Mauro Amarante on 11/1/16.
//  Copyright © 2016 Mauro Amarante. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import RealmSwift

class GameViewController: UIViewController, GameSceneDelegate {
	//outetes
	@IBOutlet weak var skView: SKView!
	
	//variables
	var scene: GameScene!

	override func viewWillAppear(_ animated: Bool) {
		super.viewDidLoad()
		
		if skView.scene == nil {
			scene = GameScene(size: skView.frame.size)
			scene.scaleMode = SKSceneScaleMode.aspectFill
			skView.ignoresSiblingOrder = true
			skView.presentScene(scene)
			scene.gameSceneDelegate = self
		}
		
		NotificationCenter.default.addObserver(self, selector: #selector(pauseGameScene), name: NSNotification.Name(rawValue: "PauseGameScene"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func pauseGameScene() {
		if scene != nil {
			if !(skView.scene?.isPaused)! {
				scene.isGamePaused = true
			}
		}
	}
	
	func gameOver(points: Int) {
		//get game data
		let realm = try! Realm()
		let data = realm.objects(gameData.self)
	
		//save data
		try! realm.write {
			if (points > (data.first?.maxPoints)!) {
				data.first?.maxPoints = points
			}
		}
		
		self.dismiss(animated: true, completion: nil)
		scene.removeFromParent()
	}
	
	func gameComplete(points: Int) {
		let alert = UIAlertController(title: "¡Felicidades!", message: "Haz completado todos los compuestos", preferredStyle: UIAlertControllerStyle.alert)
		alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
		self.present(alert, animated: true, completion: nil)
		gameOver(points: points)
	}
	

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
