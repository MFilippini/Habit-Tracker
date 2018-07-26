//
//  MenuViewController.swift
//  Habit Tracker
//
//  Created by Michael Filippini on 7/24/18.
//  Copyright © 2018 Michael Filippini. All rights reserved.
//

import UIKit




class MenuViewController: UIViewController {

    var settingsVC: UIViewController!
    var mainVC: UIViewController!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let settingsVC = storyboard.instantiateViewController(withIdentifier: "Settings") as! SettingsViewController
        
        let nav = UINavigationController(rootViewController: settingsVC)
        nav.navigationBar.backgroundColor = .blue
        print(nav.navigationBar.layer.sublayers)
        self.settingsVC = nav
        


        let mainVC = storyboard.instantiateViewController(withIdentifier: "Main") as! ViewController
        
        let nav2 = UINavigationController(rootViewController: mainVC)
        print(nav2.navigationBar.layer.sublayers)

        self.mainVC = nav2

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mainMenuButton(_ sender: Any) {
        self.slideMenuController()?.changeMainViewController(self.mainVC, close: true)
        
    }
    
    @IBAction func settingsMenuButton(_ sender: Any) {
        self.slideMenuController()?.changeMainViewController(self.settingsVC, close: true)
        
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
