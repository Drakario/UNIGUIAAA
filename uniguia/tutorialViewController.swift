//
//  tutorialViewController.swift
//  uniguia
//
//  Created by student on 30/05/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class tutorialViewController: UIViewController, UIPageViewControllerDataSource {
    
    var pageViewController: UIPageViewController?
    
    let contentImages = ["untitled-8", "untitled-7"]

    override func viewDidLoad() {
        super.viewDidLoad()
        createPageViewController()
        setupPageControl()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func createPageViewController(){
        let pageController = self.storyboard?.instantiateViewController(withIdentifier: "PageController") as! UIPageViewController
        
        pageController.dataSource = self
        
        if contentImages.count > 0 {
            let firstController = getItemController(0)!
            let startingViewControllers = [firstController]
            
            pageController.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        }
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMove(toParentViewController: self)
    }
    
    func setupPageControl(){
        let appearence = UIPageControl.appearance()
        appearence.pageIndicatorTintColor = UIColor.gray
        appearence.currentPageIndicatorTintColor = UIColor.blue
        appearence.backgroundColor = UIColor.white
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let itemController = viewController.self as! ItemViewController
        
        if itemController.itemIndex > 0{
            return getItemController(itemController.itemIndex-1)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let itemController = viewController.self as! ItemViewController
        
        if itemController.itemIndex+1 < contentImages.count{
            return getItemController(itemController.itemIndex+1)
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return contentImages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func currentControllerIndex() -> Int {
        let pageItemController = self.currentController()
        
        if let controller = pageItemController as? ItemViewController{
            return controller.itemIndex
        }
        return -1
    }
    
    func currentController() -> UIViewController? {
        if(self.pageViewController?.viewControllers?.count)! > 0{
            return (self.pageViewController?.viewControllers![0])!
        }
        return nil
    }
    
    func getItemController(_ itemIndex: Int) -> ItemViewController?{
        if itemIndex < contentImages.count{
            let pageItemController = self.storyboard?.instantiateViewController(withIdentifier: "ItemController") as! ItemViewController
            
            pageItemController.itemIndex = itemIndex
            pageItemController.imageName = contentImages[itemIndex]
            return pageItemController
        }
        return nil
    }
    
}
