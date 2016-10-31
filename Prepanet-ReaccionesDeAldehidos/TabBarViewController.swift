//
//  TabBarViewController.swift
//  Prepanet-ReaccionesDeAldehidos
//
//  Created by Mauro Amarante on 10/31/16.
//  Copyright © 2016 Mauro Amarante. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.tabBar.tintColor = UIColor.white
		self.tabBar.barTintColor = UIColor(red: 42/255, green: 70/255, blue: 101/255, alpha: 1)
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
