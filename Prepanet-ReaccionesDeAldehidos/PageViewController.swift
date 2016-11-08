//
//  PageViewController.swift
//  Prepanet-ReaccionesDeAldehidos
//
//  Created by Mauro Amarante on 11/6/16.
//  Copyright © 2016 Mauro Amarante. All rights reserved.
//

import UIKit

protocol PageControllerDelegate {
	func updatePageController(index: Int)
}

class PageViewController: UIPageViewController {
	var pages: [UIViewController] = {
		return [UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "rules1"),
		        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "rules2"),
		        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "rules3")]
	}()
	
	//protocol
	var pageControllerDelegate: PageControllerDelegate?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		dataSource = self
		
		if let firstViewController = pages.first {
			setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: UIPageViewControllerDataSource

extension PageViewController: UIPageViewControllerDataSource {
 
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		guard let viewControllerIndex = pages.index(of: viewController) else {
			return nil
		}
		
		let previousIndex = viewControllerIndex - 1
		pageControllerDelegate?.updatePageController(index: previousIndex+1)
		
		guard previousIndex >= 0 else {
			return nil
		}
		
		guard (pages.count) > previousIndex else {
			return nil
		}
		
		return pages[previousIndex]
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		guard let viewControllerIndex = pages.index(of: viewController) else {
			return nil
		}
		
		let nextIndex = viewControllerIndex + 1
		let orderedViewControllersCount = pages.count
		
		pageControllerDelegate?.updatePageController(index: nextIndex-1)
		
		guard orderedViewControllersCount != nextIndex else {
			return nil
		}
		
		guard orderedViewControllersCount > nextIndex else {
			return nil
		}
		
		return pages[nextIndex]
	}
}
