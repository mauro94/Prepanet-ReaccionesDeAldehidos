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

class GameViewController: UIViewController {

	override func viewWillLayoutSubviews() {
		super.viewDidLoad()
		
		let skView = self.view as! SKView
		if skView.scene == nil {
			let scene = GameScene(size: skView.frame.size)
			scene.scaleMode = SKSceneScaleMode.resizeFill
			skView.ignoresSiblingOrder = true
			skView.presentScene(scene)
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
