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
    
    @IBOutlet weak var editingLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    var editClicked = false
    
    // Test Data for Cells
    var habitNamesArray: [String] = ["Walk the Dog"]
    var timesCompleteArray: [Int] = [1]
    var colorsArray: [UIColor] = [Common.Global.red]
    var timesPerDayArray: [Int] = [3]
    
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
        if let savedNames = UserDefaults.standard.object(forKey: "habitNames") as? Array<String>{
            habitNamesArray = savedNames
        }
        if let savedColors = UserDefaults.standard.object(forKey: "colors") as? Array<Int>{
            colorsArray = numberToColor(numbers: savedColors)
        }
        if let savedPerDay = UserDefaults.standard.object(forKey: "timesADay") as? Array<Int>{
            timesPerDayArray = savedPerDay
        }
        if let savedCompletions = UserDefaults.standard.object(forKey: "timesComplete") as? Array<Int>{
            timesCompleteArray = savedCompletions
            if let day = UserDefaults.standard.object(forKey: "lastDay") as? String{
                let cal = Calendar.current
                if(day != "\(cal.component(.day, from: Date())):\(cal.component(.month, from: Date())):\(cal.component(.year, from: Date()))"){
                    timesCompleteArray.removeAll()
                    for _ in savedCompletions{
                        timesCompleteArray.append(0)
                    }
                    saveData()
                }
            }
        }
        habitPanels.reloadData()
    }
    
    func saveData(){
        UserDefaults.standard.set(habitNamesArray, forKey: "habitNames")
        UserDefaults.standard.set(timesCompleteArray, forKey: "timesComplete")
        UserDefaults.standard.set(colorToNumber(colors: colorsArray), forKey: "colors")
        UserDefaults.standard.set(timesPerDayArray, forKey: "timesADay")
        let cal = Calendar.current
        let lastAccess = "\(cal.component(.day, from: Date())):\(cal.component(.month, from: Date())):\(cal.component(.year, from: Date()))"
        UserDefaults.standard.set(lastAccess, forKey: "lastDay")
    }
    
    func colorToNumber(colors: [UIColor]) -> [Int] {
        var numArray: [Int] = []
        for color in colors{
            switch color{
            case Common.Global.blue:
                numArray.append(0)
            case Common.Global.green:
                numArray.append(1)
            case Common.Global.yellow:
                numArray.append(2)
            case Common.Global.orange:
                numArray.append(3)
            case Common.Global.red:
                numArray.append(4)
            case Common.Global.purple:
                numArray.append(5)
            default:
                numArray.append(6)
            }
        }
        
        return numArray
    }
    
    func numberToColor(numbers: [Int]) -> [UIColor]{
        var colorArray: [UIColor] = []
        for number in numbers{
            switch number{
            case 0:
                colorArray.append(Common.Global.blue)
            case 1:
                colorArray.append(Common.Global.green)
            case 2:
                colorArray.append(Common.Global.yellow)
            case 3:
                colorArray.append(Common.Global.orange)
            case 4:
                colorArray.append(Common.Global.red)
            case 5:
                colorArray.append(Common.Global.purple)
            default:
                colorArray.append(UIColor.white)
            }
        }
        return colorArray
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
        if !editClicked{
            cell.labelHabitName.text = habitNamesArray[indexPath.item]
        } else {
            cell.labelHabitName.text = ("Click to Edit "+habitNamesArray[indexPath.item])
        }
        cell.viewForProgressWheel.layer.addSublayer(CALayer())
        makeCircle(cell: cell, indexOfCell: indexPath.item)
        
        return cell
    }
    
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: self.habitPanels)
        let indexPath = self.habitPanels.indexPathForItem(at: location)
        
        if let index = indexPath {
            if(!editClicked){
                // prepare haptic
                let timesPerDay = timesPerDayArray[index.item]
                if (timesCompleteArray[index.item]<timesPerDay){
                    timesCompleteArray[index.item] += 1
                    habitPanels.reloadItems(at: [index])
                    // do happy haptic
                } else {
                    // do NOPE haptic
                }
                saveData()
            } else {
                performSegue(withIdentifier: "toEditPanel", sender: index)
            }
        }
    }
    
    @IBAction func addNewHabitTapped(_ sender: Any) {
        performSegue(withIdentifier: "addNewHabit", sender: nil)
    }
    
    @IBAction func editingModeActivate(_ sender: UIBarButtonItem) {
        editClicked = !editClicked
        addButton.isHidden = !addButton.isHidden
        editingLabel.isHidden = !editingLabel.isHidden
        if editClicked{
            editButton.title = "Finish Editing"
        }else{
            editButton.title = "Edit"
        }
        habitPanels.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "addNewHabit"?:
            let dvc = segue.destination as! AddNewHabitScreen
            dvc.habitNamesArray = habitNamesArray
            dvc.timesCompleteArray = timesCompleteArray
            dvc.timesPerDayArray = timesPerDayArray
            dvc.colorsArray = colorsArray
        case "toEditPanel"?:
            let dvc = segue.destination as! CellEditingView
            dvc.habitNamesArray = habitNamesArray
            dvc.timesCompleteArray = timesCompleteArray
            dvc.timesPerDayArray = timesPerDayArray
            dvc.colorsArray = colorsArray
            dvc.indexOfEdit = sender as! NSIndexPath
        default: break
            
        }
    }
    
    @IBAction func unwindToInitialViewController(segue: UIStoryboardSegue){
        saveData()
    }
    
}

