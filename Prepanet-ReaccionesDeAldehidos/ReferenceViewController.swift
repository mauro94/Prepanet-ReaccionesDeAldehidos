//
//  ReferenceViewController.swift
//  Prepanet-ReaccionesDeAldehidos
//
//  Created by Mauro Amarante on 10/28/16.
//  Copyright © 2016 Mauro Amarante. All rights reserved.
//

import UIKit

private let reuseIdentifier = "referenceCell"
private let itemsPerRow: CGFloat = 2
private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)

class ReferenceViewController: UICollectionViewController {

    let sectionsCodes = ["Ald", "Nom", "Rea", "Us", "Sin"]
    let sectionNames = ["Aldehídos", "Nomenclatura", "Reacciones", "Usos", "Síntesis"]
    let sectionNumbers = ["1", "2", "3", "4", "5"]
	let randomNumbers = ["1.364232", "0.432425", "0.765356", "2.3446", "1.3265362"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(ReferenceCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let view = segue.destination as! ReferencePDFViewController
        
        let cell = sender as! ReferenceCollectionViewCell
        
        view.section = cell.lbCode.text!
        
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
 

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ReferenceCollectionViewCell
		
        let index = indexPath.row
        
        cell.lbCode.text = sectionsCodes[index]
        cell.lbName.text = sectionNames[index]
        cell.lbNumber.text = sectionNumbers[index]
		cell.lbRandomNumber.text = randomNumbers[index]
        
		//modify cell border and background
		cell.layer.borderWidth = 3
		cell.layer.borderColor = UIColor.black.cgColor
		cell.backgroundColor = UIColor(red: 42/255, green: 70/255, blue: 101/255, alpha: 0.2)
		
		//modify cell labels
		
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
	
}

extension ReferenceViewController : UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
		let availableWidth = view.frame.width - paddingSpace
		let widthPerItem = availableWidth / itemsPerRow
		
		return CGSize(width: widthPerItem, height: widthPerItem)
	}
 
	func collectionView(_ collectionView: UICollectionView,
	                    layout collectionViewLayout: UICollectionViewLayout,
	                    insetForSectionAt section: Int) -> UIEdgeInsets {
		return sectionInsets
	}
 
	func collectionView(_ collectionView: UICollectionView,
	                    layout collectionViewLayout: UICollectionViewLayout,
	                    minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return sectionInsets.left
	}
}
