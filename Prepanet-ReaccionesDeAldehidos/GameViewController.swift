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

class GameViewController: UIViewController, GameSceneDelegate {
	@IBOutlet weak var skView: SKView!

	override func viewWillAppear(_ animated: Bool) {
		super.viewDidLoad()
		
		if skView.scene == nil {
			let scene = GameScene(size: skView.frame.size)
			scene.scaleMode = SKSceneScaleMode.aspectFill
			skView.ignoresSiblingOrder = true
			skView.presentScene(scene)
			scene.gameSceneDelegate = self
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func gameOver() {
		self.dismiss(animated: true, completion: nil);
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
