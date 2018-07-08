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

    @IBOutlet weak var addButton: UIButton!
    
    var editClicked = false
    
    // Test Data for Cells
    var habitNamesArray: [String] = ["Walk the Dog","Make my Bed","Take out Garbage","Workout","Read","Pray","Call Clients"]
    var timesCompleteArray: [Int] = [1,1,0,1,2,4,1]
    var colorsArray: [UIColor] = [Common.Global.red,Common.Global.blue,Common.Global.purple,Common.Global.green,Common.Global.orange,Common.Global.yellow,Common.Global.purple]
    var timesPerDayArray: [Int] = [3,1,1,3,3,5,6]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        habitPanels.dataSource = self
        habitPanels.delegate = self
        
        addButton.layer.borderWidth = 3
        addButton.layer.borderColor = Common.Global.lightGrey.cgColor
        addButton.backgroundColor = Common.Global.darkGrey
        addButton.layer.cornerRadius = 34
    }
    
    override func viewDidAppear(_ animated: Bool) {
        habitPanels.reloadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeCircle(cell: HabitCell, indexOfCell: Int){
        let backgroundCircle = CAShapeLayer()
        let outsideRing = CAShapeLayer()
        // outside ring only appears in the animation as the progress bar
        
        for layer in cell.viewForProgressWheel.layer.sublayers!{
            layer.removeFromSuperlayer()
        }
        
        outsideRing.path = UIBezierPath(arcCenter: cell.viewForProgressWheel.center, radius: 70, startAngle: CGFloat(-Float.pi/2.0), endAngle: CGFloat(1.5*Float.pi), clockwise: true).cgPath
        
        outsideRing.fillColor = UIColor.clear.cgColor
        outsideRing.lineWidth = 8
        outsideRing.strokeEnd = 0
        outsideRing.zPosition = -50
        outsideRing.lineCap = kCALineCapRound
        
        // background circle is similar to the ring but it has a fill color and displays a "track in grey"
        backgroundCircle.path = UIBezierPath(arcCenter: cell.viewForProgressWheel.center, radius: 70, startAngle: CGFloat(-Float.pi/2.0), endAngle: CGFloat(1.5*Float.pi), clockwise: true).cgPath
        
        backgroundCircle.strokeColor = Common.Global.lightGrey.cgColor
        backgroundCircle.fillColor = Common.Global.darkGrey.cgColor
        backgroundCircle.lineWidth = 8
        backgroundCircle.strokeEnd = 0
        backgroundCircle.zPosition = -60
        backgroundCircle.strokeEnd = 1
        cell.viewForProgressWheel.layer.addSublayer(backgroundCircle)
        cell.viewForProgressWheel.layer.addSublayer(outsideRing)
        ringAnimate(ring: outsideRing, indexOfCell: indexOfCell)
    }
    
    func ringAnimate(ring: CAShapeLayer, indexOfCell: Int){
        let progressBarAnimate = CABasicAnimation(keyPath: "strokeEnd")
        let progressPercent = Float32(timesCompleteArray[indexOfCell]) / Float32(timesPerDayArray[indexOfCell])
        progressBarAnimate.toValue = CGFloat(progressPercent)
        progressBarAnimate.duration = 0.7
        ring.strokeColor = colorsArray[indexOfCell].cgColor
        progressBarAnimate.isRemovedOnCompletion = false
        progressBarAnimate.fillMode = kCAFillModeForwards
        
        ring.add(progressBarAnimate,forKey: nil)
    }
    
    // collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return habitNamesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = habitPanels.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HabitCell
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        cell.labelHabitName.text = habitNamesArray[indexPath.item]
        cell.viewForProgressWheel.layer.addSublayer(CALayer())
        makeCircle(cell: cell, indexOfCell: indexPath.item)
        
        return cell
    }
    
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: self.habitPanels)
        let indexPath = self.habitPanels.indexPathForItem(at: location)
        
        if let index = indexPath {
            // prepare haptic
            let timesPerDay = timesPerDayArray[index.item]
            if (timesCompleteArray[index.item]<timesPerDay){
                timesCompleteArray[index.item] += 1
                habitPanels.reloadItems(at: [index])
                // do happy haptic
            } else {
                // do NOPE haptic
            }
        }
    }

    @IBAction func addNewHabitTapped(_ sender: Any) {
        performSegue(withIdentifier: "addNewHabit", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "addNewHabit"?:
            let dvc = segue.destination as! AddNewHabitScreen
            dvc.habitNamesArray = habitNamesArray
            dvc.timesCompleteArray = timesCompleteArray
            dvc.timesPerDayArray = timesPerDayArray
            dvc.colorsArray = colorsArray
        default: break
            
        }
    }
    
    @IBAction func unwindToInitialViewController(segue: UIStoryboardSegue){
    }
    
}

