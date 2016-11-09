//
//  ReferencePDFViewController.swift
//  Prepanet-ReaccionesDeAldehidos
//
//  Created by Fabian Montemayor on 11/9/16.
//  Copyright © 2016 Mauro Amarante. All rights reserved.
//

import UIKit

class ReferencePDFViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var section = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if section != "" {
            let bundle = Bundle.main
            let path = bundle.path(forResource: section, ofType: "pdf")
            let url = NSURL(fileURLWithPath: path!)
            webView.loadRequest(NSURLRequest(url: url as URL) as URLRequest)
        }
        else {
            self.dismiss(animated: true, completion: nil)
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
