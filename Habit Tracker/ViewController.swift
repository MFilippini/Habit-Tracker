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
    var habitNamesArray = ["Workout","Walk the Dog","Read","Ddfgudrtijdrr trtrtrtftfff tfthcrfftcftcfcf ccfcftytyty wafnjdf "]
    var viewProgressTrackerArray = [[Common.Global.blue],[Common.Global.green],[Common.Global.purple],[Common.Global.yellow]]
    
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
        progressBarAnimate.fromValue = CGFloat(-0.5*Float.pi)
        progressBarAnimate.toValue = CGFloat(1.5*Float.pi)
        progressBarAnimate.duration = 3.5
        //
        //          CHANGE COLOR OF STROKE BASED ON ITS INDEX
        //
        let colorArray = viewProgressTrackerArray[indexOfCell]
        let color = colorArray[0].cgColor
        circle.strokeColor = color
        //
        //
        //
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

