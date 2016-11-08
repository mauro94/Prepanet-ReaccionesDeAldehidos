//
//  GlosarioViewController.swift
//  Prepanet-ReaccionesDeAldehidos
//
//  Created by Mauro Amarante on 11/7/16.
//  Copyright © 2016 Mauro Amarante. All rights reserved.
//

import UIKit

class GlosarioViewController: UIViewController {
	@IBOutlet weak var img1: UIImageView!
	@IBOutlet weak var img2: UIImageView!
	@IBOutlet weak var img3: UIImageView!
	@IBOutlet weak var img4: UIImageView!
	@IBOutlet weak var lb1: UILabel!
	@IBOutlet weak var lb2: UILabel!
	@IBOutlet weak var lb3: UILabel!
	@IBOutlet weak var lb4: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		if (self.view.frame.size.height <= 640) {
			img1.isHidden = false
			img2.isHidden = false
			img3.isHidden = false
			img4.isHidden = false
			lb1.isHidden = false
			lb2.isHidden = false
			lb3.isHidden = false
			lb4.isHidden = false
		}
		
		if (self.view.frame.size.height <= 750) {
			img1.isHidden = false
			lb1.isHidden = false
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
