//
//  PageViewController.swift
//  page
//
//  Created by Danilo Braband on 01.07.14.
//  Copyright (c) 2014 Danilo Braband. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    let controllers: String[] = [
        "firstViewController",
        "secondViewController",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.groupTableViewBackgroundColor()

        // Do any additional setup after loading the view.
        self.delegate = self
        self.dataSource = self

        self.setViewControllers([self.storyboard.instantiateViewControllerWithIdentifier(self.controllers[0])], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // #pragma mark - Helpers

    func indexOf(string: String, inArray array: String[]) -> Int {
        return find(array, string)!
    }


    // #pragma mark - UPageViewControllerDataSource

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

}
