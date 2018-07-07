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
    var habitNamesArray: [String] = ["Walk the Dog","Make my Bed","Take out Garbage","Workout","Read","Pray","Call Clients"]
    var timesCompleteArray: [Int] = [1,1,0,1,2,4,1]
    var colorsArray: [UIColor] = [Common.Global.red,Common.Global.blue,Common.Global.purple,Common.Global.green,Common.Global.orange,Common.Global.yellow,Common.Global.purple]
    var timesPerDayArray: [Int] = [3,1,1,3,3,5,6]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        habitPanels.dataSource = self
        habitPanels.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeCircle(cell: HabitCell, indexOfCell: Int){
        let circle = CAShapeLayer()
        circle.path = UIBezierPath(arcCenter: cell.viewForProgressWheel.center, radius: 70, startAngle: CGFloat(-Float.pi/2.0), endAngle: CGFloat(1.5*Float.pi), clockwise: true).cgPath
        circle.fillColor = UIColor(red: 41/255.0, green: 41/255.0, blue: 41/255.0, alpha: 1).cgColor
        circle.lineWidth = 8
        circle.strokeEnd = 0
        circle.zPosition = -5
        cell.viewForProgressWheel.layer.addSublayer(circle)
        circleAnimate(circle: circle, indexOfCell: indexOfCell)
    }
    
    func circleAnimate(circle: CAShapeLayer, indexOfCell: Int){
        let progressBarAnimate = CABasicAnimation(keyPath: "strokeEnd")
        let progressPercent = Float32(timesCompleteArray[indexOfCell]) / Float32(timesPerDayArray[indexOfCell])
        progressBarAnimate.toValue = CGFloat(progressPercent)
        progressBarAnimate.duration = 0.7
        circle.strokeColor = colorsArray[indexOfCell].cgColor
        progressBarAnimate.isRemovedOnCompletion = false
        progressBarAnimate.fillMode = kCAFillModeForwards
        circle.add(progressBarAnimate,forKey: nil)
    }

    // collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return habitNamesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = habitPanels.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HabitCell
        cell.labelHabitName.text = habitNamesArray[indexPath.item]
        //cell.labelHabitName.textColor = some array position
        makeCircle(cell: cell, indexOfCell: indexPath.item)
        return cell
    }
    
    
    
}

