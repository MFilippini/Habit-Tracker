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
    
    func makeCircle(cell: HabitCell, indexOfCell: Int) -> UIView{
        
        let viewSet = UIView()
        let backgroundCircle = CAShapeLayer()
        let outsideRing = CAShapeLayer()
        // outside ring only appears in the animation as the progress bar
        outsideRing.path = UIBezierPath(arcCenter: cell.viewForProgressWheel.center, radius: 70, startAngle: CGFloat(-Float.pi/2.0), endAngle: CGFloat(1.5*Float.pi), clockwise: true).cgPath
        
        outsideRing.fillColor = UIColor.clear.cgColor
        outsideRing.lineWidth = 8
        outsideRing.strokeEnd = 0
        outsideRing.zPosition = -1
        outsideRing.lineCap = kCALineCapRound
        
        // background circle is similar to the ring but it has a fill color and displays a "track in grey"
        backgroundCircle.path = UIBezierPath(arcCenter: cell.viewForProgressWheel.center, radius: 70, startAngle: CGFloat(-Float.pi/2.0), endAngle: CGFloat(1.5*Float.pi), clockwise: true).cgPath
        
        backgroundCircle.strokeColor = UIColor(red: 103/255.0, green: 103/255.0, blue: 103/255.0, alpha: 1).cgColor //light grey
        //backgroundCircle.fillColor = UIColor(red: 41/255.0, green: 41/255.0, blue: 41/255.0, alpha: 1).cgColor //dark grey
        backgroundCircle.fillColor = UIColor.clear.cgColor
        backgroundCircle.lineWidth = 8
        backgroundCircle.strokeEnd = 0
        backgroundCircle.zPosition = -2
        backgroundCircle.strokeEnd = 1
        
        
        viewSet.layer.addSublayer(backgroundCircle)
        viewSet.layer.addSublayer(outsideRing)
        
        let progressBarAnimate = CABasicAnimation(keyPath: "strokeEnd")
        let progressPercent = Float32(timesCompleteArray[indexOfCell]) / Float32(timesPerDayArray[indexOfCell])
        progressBarAnimate.toValue = CGFloat(progressPercent)
        progressBarAnimate.duration = 0.7
        outsideRing.strokeColor = colorsArray[indexOfCell].cgColor
        progressBarAnimate.isRemovedOnCompletion = false
        progressBarAnimate.fillMode = kCAFillModeForwards
        
        outsideRing.add(progressBarAnimate,forKey: nil)
        
        return viewSet
    }
    
//    func ringAnimate(ring: CAShapeLayer, indexOfCell: Int, viewSet: UIView) -> UIView{
//        let progressBarAnimate = CABasicAnimation(keyPath: "strokeEnd")
//        let progressPercent = Float32(timesCompleteArray[indexOfCell]) / Float32(timesPerDayArray[indexOfCell])
//        progressBarAnimate.toValue = CGFloat(progressPercent)
//        progressBarAnimate.duration = 0.7
//        ring.strokeColor = colorsArray[indexOfCell].cgColor
//        progressBarAnimate.isRemovedOnCompletion = false
//        progressBarAnimate.fillMode = kCAFillModeForwards
//
//        ring.add(progressBarAnimate,forKey: nil)
//        return viewSet
//    }

    // collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return habitNamesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = habitPanels.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HabitCell
        cell.viewForProgressWheel.addSubview(makeCircle(cell: cell, indexOfCell: indexPath.item))
        cell.labelHabitName.text = habitNamesArray[indexPath.item]
        return cell
    }
    
    @IBAction func updateTapped(_ sender: Any) {
        timesCompleteArray = [2,1,1,1,2,4,3]
        habitPanels.reloadData()
    }
    
    
}

