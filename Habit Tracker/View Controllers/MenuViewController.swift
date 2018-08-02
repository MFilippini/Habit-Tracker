//
//  MenuViewController.swift
//  Habit Tracker
//
//  Created by Michael Filippini on 7/24/18.
//  Copyright © 2018 Michael Filippini. All rights reserved.
//

import UIKit




class MenuViewController: UIViewController {

    
    @IBOutlet weak var habitsButton: UIButton!
    @IBOutlet weak var statsButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var logoBackdrop: UIView!
    
    
    var settingsVC: UIViewController!
    var mainVC: UIViewController!
    var statsVC: UIViewController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuSegues()
//        setupButton(button: habitsButton, color: "red")
//        setupButton(button: statsButton, color: "orange")
//        setupButton(button: settingsButton, color: "yellow")
//        logoBackdrop.layer.cornerRadius = 20
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupButton(button: habitsButton, color: "red")
        setupButton(button: statsButton, color: "orange")
        setupButton(button: settingsButton, color: "yellow")
        logoBackdrop.layer.cornerRadius = 20
    }
    
    func setupButton(button: UIButton,color: String){
        button.layer.borderWidth = 5
        var palatte = 0
        if let palatte2 = UserDefaults.standard.object(forKey: "palatte") as? Int{
            palatte = palatte2
        }
        button.layer.borderColor = colors[color]![palatte].cgColor
        button.backgroundColor = darkGrey
        button.layer.cornerRadius = 30
    }
    
    fileprivate func setupMenuSegues() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let colorVal: CGFloat = 27
        
        let settingsVC = storyboard.instantiateViewController(withIdentifier: "Settings") as! SettingsViewController
        let mainVC = storyboard.instantiateViewController(withIdentifier: "Main") as! ViewController
        let statsVC = storyboard.instantiateViewController(withIdentifier: "Stats") as! StatsViewController
        
        var nav = UINavigationController(rootViewController: settingsVC)
        
        nav.navigationBar.barStyle = .black
        nav.navigationBar.alpha = 1
        nav.navigationBar.backgroundColor = UIColor(red: colorVal/255.0, green: colorVal/255.0, blue: colorVal/255.0, alpha: 1)
        nav.navigationBar.barTintColor = UIColor(red: colorVal/255.0, green: colorVal/255.0, blue: colorVal/255.0, alpha: 1)
        nav.navigationBar.tintColor = .white
        self.settingsVC = nav
        
        nav = UINavigationController(rootViewController: mainVC)
        
        nav.navigationBar.barStyle = .black
        nav.navigationBar.alpha = 1
        nav.navigationBar.backgroundColor = UIColor(red: colorVal/255.0, green: colorVal/255.0, blue: colorVal/255.0, alpha: 1)
        nav.navigationBar.barTintColor = UIColor(red: colorVal/255.0, green: colorVal/255.0, blue: colorVal/255.0, alpha: 1)
        nav.navigationBar.tintColor = .white
        self.mainVC = nav
        
        nav = UINavigationController(rootViewController: statsVC)
        
        nav.navigationBar.barStyle = .black
        nav.navigationBar.alpha = 1
        nav.navigationBar.backgroundColor = UIColor(red: colorVal/255.0, green: colorVal/255.0, blue: colorVal/255.0, alpha: 1)
        nav.navigationBar.barTintColor = UIColor(red: colorVal/255.0, green: colorVal/255.0, blue: colorVal/255.0, alpha: 1)
        nav.navigationBar.tintColor = .white
        self.statsVC = nav
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
    
    @IBAction func statsMenuButton(_ sender: Any) {
        self.slideMenuController()?.changeMainViewController(self.statsVC, close: true)
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
