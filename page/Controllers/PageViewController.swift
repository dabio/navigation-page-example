//
//  PageViewController.swift
//  page
//
//  Created by Danilo Braband on 01.07.14.
//  Copyright (c) 2014 Danilo Braband. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    let controllers: [String] = [
        "firstViewController",
        "secondViewController",
        "thirdViewController",
    ]

    lazy var pageControl: UIPageControl = {
        let pageControl: UIPageControl = UIPageControl()
        pageControl.numberOfPages = self.controllers.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.grayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.darkGrayColor()
        pageControl.frame = CGRect(
            origin: CGPoint(x: 0, y: 10),
            size: pageControl.sizeForNumberOfPages(pageControl.numberOfPages)
        )
        pageControl.addTarget(self, action: "pageControlChanged:", forControlEvents: UIControlEvents.ValueChanged)
        return pageControl
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate = self
        self.dataSource = self

        self.view.backgroundColor = UIColor.groupTableViewBackgroundColor()

        self.setViewControllers([self.storyboard.instantiateViewControllerWithIdentifier(self.controllers[0])], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)

        self.navigationItem.titleView = self.pageControl

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


  //MARK: - Actions

    func pageControlChanged(pageControl: UIPageControl) {

        // get position of current view controller
        let vc: UIViewController = self.viewControllers[0] as UIViewController
        let position: Int = find(self.controllers, vc.restorationIdentifier)!

        // get direction to go to
        if position > pageControl.currentPage {
            self.setViewControllers([self.pageViewController(self, viewControllerBeforeViewController: vc)], direction: UIPageViewControllerNavigationDirection.Reverse, animated: true, completion: nil)
        } else {
            self.setViewControllers([self.pageViewController(self, viewControllerAfterViewController: vc)], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        }
    }


    //MARK: - UPageViewControllerDataSource

    func pageViewController(pageViewController: UIPageViewController!, viewControllerBeforeViewController viewController: UIViewController!) -> UIViewController! {

        let position: Int = find(self.controllers, viewController.restorationIdentifier)!
        if position == 0 {
            return nil
        }

        return self.storyboard.instantiateViewControllerWithIdentifier(self.controllers[position - 1]) as UIViewController
    }

    func pageViewController(pageViewController: UIPageViewController!, viewControllerAfterViewController viewController: UIViewController!) -> UIViewController! {

        let position: Int = find(self.controllers, viewController.restorationIdentifier)!
        if position == self.controllers.count - 1 {
            return nil
        }

        return self.storyboard.instantiateViewControllerWithIdentifier(self.controllers[position + 1]) as UIViewController
    }


    //MARK: - UPageViewControllerDelegate

    func pageViewController(pageViewController: UIPageViewController!, didFinishAnimating finished: Bool, previousViewControllers: [AnyObject]!, transitionCompleted completed: Bool) {

        let vc: UIViewController = pageViewController.viewControllers[0] as UIViewController
        let position: Int = find(self.controllers, vc.restorationIdentifier)!

        self.pageControl.currentPage = position
    }

}
