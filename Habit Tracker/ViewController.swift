//
//  ViewController.swift
//  Habit Tracker
//
//  Created by Michael Filippini on 7/5/18.
//  Copyright © 2018 Michael Filippini. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var habitPanels: UICollectionView!
    
    var habitNamesArray = ["Workout"]
    var viewWithProgressTracker = [UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        habitPanels.dataSource = self
        habitPanels.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return habitNamesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = habitPanels.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HabitCell
        cell.viewForProgressWheel = viewWithProgressTracker[indexPath.item]
        cell.labelHabitName.text = habitNamesArray[indexPath.item]
        return cell
    }
}

