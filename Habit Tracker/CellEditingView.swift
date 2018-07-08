//
//  CellEditingView.swift
//  Habit Tracker
//
//  Created by Michael Filippini on 7/8/18.
//  Copyright © 2018 Michael Filippini. All rights reserved.
//

import UIKit

class CellEditingView: UIViewController {

    @IBOutlet weak var renameHabitTextField: UITextField!
    @IBOutlet weak var renameDoneButton: UIButton!
    
    @IBOutlet weak var timesPerDayLabel: UILabel!
    @IBOutlet weak var timesCompletedTodayLabel: UILabel!
    
    @IBOutlet weak var colorSelectEdit: UICollectionView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
