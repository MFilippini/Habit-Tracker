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
    
    //
    var editClicked = false
    
    // Data for Cells
    var habitNamesArray = ["Workout","Eat Salad","Take a Shower"]
    var viewProgressTrackerArray = [Common.Global.blue,Common.Global.green,Common.Global.purple]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        habitPanels.dataSource = self
        habitPanels.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func makeCircle(cell: HabitCell) -> CAShapeLayer{
        var circle = CAShapeLayer()
        
        
        circle.path = UIBezierPath(arcCenter: cell.viewForProgressWheel.center , radius: 20, startAngle: CGFloat(-Float.pi), endAngle: 0, clockwise: true).cgPath
        circle.fillColor = UIColor.black.cgColor
        circle.strokeColor = Common.Global.purple.cgColor
        circle.lineWidth = 5
        circle.strokeEnd = 0.0
        return circle
    }
    
    
    
    
    
    
    
    // collection view
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return habitNamesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = habitPanels.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HabitCell
        cell.viewForProgressWheel.layer.addSublayer( makeCircle(cell: cell) )
        cell.labelHabitName.text = habitNamesArray[indexPath.item]
        return cell
    }
    
    
    
}

