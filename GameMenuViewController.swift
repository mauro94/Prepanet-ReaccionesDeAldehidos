//
//  GameViewController.swift
//  Prepanet-ReaccionesDeAldehidos
//
//  Created by Mauro Amarante on 10/31/16.
//  Copyright © 2016 Mauro Amarante. All rights reserved.
//

import UIKit
import RealmSwift

class GameMenuViewController: UIViewController, PageControllerDelegate {
	//outlets
	@IBOutlet weak var pagesView: UIView!
	@IBOutlet weak var pageControl: UIPageControl!
	@IBOutlet weak var btPlay: UIButton!

	//variables
	var results: Results<gameData>!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.title = "Juego"
		pageControl.numberOfPages = 3
		pageControl.pageIndicatorTintColor = UIColor(red: 42/255, green: 70/255, blue: 101/255, alpha: 0.5)
		pageControl.currentPageIndicatorTintColor = UIColor(red: 42/255, green: 70/255, blue: 101/255, alpha: 1)
		
		let realm = try! Realm()
		
		results = realm.objects(gameData.self)
		
		if !(results.first?.rulesSeen)! {
			btPlay.isEnabled = false
			btPlay.setTitle("Leer instrucciones", for: .normal)
		}
		else {
			btPlay.setTitle("Jugar", for: .normal)
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// Get the new view controller using segue.destinationViewController.
		// Pass the selected object to the new view controller.
		if let pageViewController = segue.destination as? PageViewController {
			pageViewController.pageControllerDelegate = self
		}
	}
	
	func updatePageController(index: Int) {
		pageControl.currentPage = index
		
		if !(results.first?.rulesSeen)! {
			if (index == 2) {
				let realm = try! Realm()
				
				try! realm.write {
					results.first?.rulesSeen = true
				}
				
				btPlay.isEnabled = true
				btPlay.setTitle("Jugar", for: .normal)
			}
		}
	}
}
