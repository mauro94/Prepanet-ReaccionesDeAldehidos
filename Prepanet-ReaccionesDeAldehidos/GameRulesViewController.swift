//
//  GameRulesViewController.swift
//  Prepanet-ReaccionesDeAldehidos
//
//  Created by Mauro Amarante on 11/7/16.
//  Copyright © 2016 Mauro Amarante. All rights reserved.
//

import UIKit
import RealmSwift

class GameRulesViewController: UIViewController {
	@IBOutlet weak var lbMaxPoints: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
	override func viewWillAppear(_ animated: Bool) {
		//get game data
		let realm = try! Realm()
		let data = realm.objects(gameData.self)
		
		//assign points
		lbMaxPoints.text = "\(data.first!.maxPoints)"
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
