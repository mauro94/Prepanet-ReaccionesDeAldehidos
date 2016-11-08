//
//  GameViewController.swift
//  Prepanet-ReaccionesDeAldehidos
//
//  Created by Mauro Amarante on 10/31/16.
//  Copyright © 2016 Mauro Amarante. All rights reserved.
//

import UIKit

class GameMenuViewController: UIViewController, PageControllerDelegate {
	//outlets
	@IBOutlet weak var pagesView: UIView!
	@IBOutlet weak var pageControl: UIPageControl!

	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.title = "Juego"
		pageControl.numberOfPages = 3
		pageControl.pageIndicatorTintColor = UIColor(red: 42/255, green: 70/255, blue: 101/255, alpha: 0.5)
		pageControl.currentPageIndicatorTintColor = UIColor(red: 42/255, green: 70/255, blue: 101/255, alpha: 1)
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
	}
}
