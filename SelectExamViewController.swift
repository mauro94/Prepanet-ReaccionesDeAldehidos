//
//  SelectExamViewController.swift
//  Prepanet-ReaccionesDeAldehidos
//
//  Created by Fabian Montemayor on 11/6/16.
//  Copyright © 2016 Mauro Amarante. All rights reserved.
//

import UIKit

class SelectExamViewController: UIViewController {
    @IBOutlet weak var sgcDifficulty: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.title = "Examen"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let view = segue.destination as! NavigationController
        
        let index = sgcDifficulty.selectedSegmentIndex
        
        if index == 0 {
            view.difficulty = "Easy"
        }
        else  if index == 1 {
            view.difficulty = "Medium"
        }
        else {
            view.difficulty = "Hard"
        }
        
        
    }
    

}
