//
//  ContainerViewController.swift
//  Habit Tracker
//
//  Created by Michael Filippini on 7/20/18.
//  Copyright © 2018 Michael Filippini. All rights reserved.
//

import UIKit
import QuartzCore

class ContainerViewController: UIViewController {

    var centerNavigationController: UINavigationController!
    var ViewController: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewController = UIStoryboard.ViewController()
        ViewController.delegate = self
        
        // wrap the centerViewController in a navigation controller, so we can push views to it
        // and display bar button items in the navigation bar
        centerNavigationController = UINavigationController(rootViewController: ViewController)
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        
        centerNavigationController.didMove(toParentViewController: self)
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

extension ContainerViewController: ViewControllerDelegate {
    
    func toggleLeftPanel() {
    }
    
    
    func addLeftPanelViewController() {
    }
    
    
    func animateLeftPanel(shouldExpand: Bool) {
    }
    
}

private extension UIStoryboard {
    
    static func main() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }
    
    static func leftViewController() -> SidePanelViewController? {
        return main().instantiateViewController(withIdentifier: "LeftViewController") as? SidePanelViewController
    }
    
    
    static func ViewController() -> ViewController? {
        return main().instantiateViewController(withIdentifier: "ViewController") as? ViewController
    }
}



