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
    @IBOutlet weak var editButton: UIButton!
    
    var editClicked = false
    
    // First Time Opening App Preset Habits
    var habitNamesArray: [String] = ["Walk the Dog","Workout","Meditate","Drink Water"]
    var timesCompleteArray: [Int] = [1,1,2,3]
    var colorsArray = ["red","orange","purple","blue"]
    var timesPerDayArray: [Int] = [3,2,4,8]
    var palatteIdentifier = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarItem()
        
        habitPanels.dataSource = self
        habitPanels.delegate = self
        
        // Makes button fit theme
        addButton.layer.borderWidth = 3
        addButton.layer.borderColor = lightGrey.cgColor
        addButton.backgroundColor = darkGrey
        addButton.layer.cornerRadius = 34
        
        editButton.layer.borderWidth = 3
        editButton.layer.borderColor = lightGrey.cgColor
        editButton.backgroundColor = darkGrey
        editButton.layer.cornerRadius = 10
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    //gets save data
    override func viewDidAppear(_ animated: Bool) {
        if let savedNames = UserDefaults.standard.object(forKey: "habitNames") as? Array<String>{
            habitNamesArray = savedNames
        }
        if let savedColors = UserDefaults.standard.object(forKey: "colors") as? Array<String>{
            colorsArray = savedColors
        }
        if let savedPerDay = UserDefaults.standard.object(forKey: "timesADay") as? Array<Int>{
            timesPerDayArray = savedPerDay
        }
        if let palatte = UserDefaults.standard.object(forKey: "palatte") as? Int{
            palatteIdentifier = palatte
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
    
    
    //saves data
    func saveData(){
        print("saved")
        UserDefaults.standard.set(habitNamesArray, forKey: "habitNames")
        UserDefaults.standard.set(timesCompleteArray, forKey: "timesComplete")
        UserDefaults.standard.set(colorsArray, forKey: "colors")
        UserDefaults.standard.set(timesPerDayArray, forKey: "timesADay")
        UserDefaults.standard.set(palatteIdentifier, forKey: "palatte")
        let cal = Calendar.current
        let lastAccess = "\(cal.component(.day, from: Date())):\(cal.component(.month, from: Date())):\(cal.component(.year, from: Date()))"
        
        UserDefaults.standard.set(lastAccess, forKey: "lastDay")
    }
    
    // save data except for time to avoid issue where being in edit panel could avoid reset
    func saveDataFromOtherView(){
        print("saved")
        UserDefaults.standard.set(habitNamesArray, forKey: "habitNames")
        UserDefaults.standard.set(timesCompleteArray, forKey: "timesComplete")
        UserDefaults.standard.set(colorsArray, forKey: "colors")
        UserDefaults.standard.set(timesPerDayArray, forKey: "timesADay")
        UserDefaults.standard.set(palatteIdentifier, forKey: "palatte")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // creates 2 circles for the background/track and one for progress
    func makeCircle(cell: HabitCell, indexOfCell: Int){
        let backgroundCircle = CAShapeLayer()
        let outsideRing = CAShapeLayer()
       
        
        // fixes error that would make circles overlap
        for layer in cell.viewForProgressWheel.layer.sublayers!{
            layer.removeFromSuperlayer()
        }
        
         // outside ring only appears in the animation as the progress bar
        outsideRing.path = UIBezierPath(arcCenter: cell.viewForProgressWheel.center, radius: 70, startAngle: CGFloat(-Float.pi/2.0), endAngle: CGFloat(1.5*Float.pi), clockwise: true).cgPath
        
        outsideRing.fillColor = UIColor.clear.cgColor
        outsideRing.lineWidth = 8
        outsideRing.strokeEnd = 0
        outsideRing.zPosition = -50
        outsideRing.lineCap = kCALineCapRound
        
        // background circle is similar to the ring but it has a fill color and displays a "track in grey"
        backgroundCircle.path = UIBezierPath(arcCenter: cell.viewForProgressWheel.center, radius: 70, startAngle: CGFloat(-Float.pi/2.0), endAngle: CGFloat(1.5*Float.pi), clockwise: true).cgPath
        
        backgroundCircle.strokeColor = lightGrey.cgColor
        backgroundCircle.fillColor = darkGrey.cgColor
        backgroundCircle.lineWidth = 8
        backgroundCircle.zPosition = -60 // behind the ring
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
        ring.strokeColor = colors[colorsArray[indexOfCell]]![palatteIdentifier].cgColor
        progressBarAnimate.isRemovedOnCompletion = false
        progressBarAnimate.fillMode = kCAFillModeForwards
        
        ring.add(progressBarAnimate,forKey: nil)
    }
    
    // collection view setup
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return habitNamesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = habitPanels.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HabitCell
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        
        // changes text when edit mode is on
        if !editClicked{
            cell.labelHabitName.text = habitNamesArray[indexPath.item]
        } else {
            cell.labelHabitName.text = ("Edit: "+habitNamesArray[indexPath.item])
        }
        
        //avoids crashing
        cell.viewForProgressWheel.layer.addSublayer(CALayer())
        
        makeCircle(cell: cell, indexOfCell: indexPath.item)
        
        return cell
    }
    
    // lets collection view know when tapped
    @objc func tap(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: self.habitPanels)
        let indexPath = self.habitPanels.indexPathForItem(at: location)
        let haptic = UINotificationFeedbackGenerator()
        if let index = indexPath {
            //different actions when edit mode
            
            if(!editClicked){
                haptic.prepare() // prepare haptic
                let timesPerDay = timesPerDayArray[index.item]
                
                // asks if can increment times complete
                if (timesCompleteArray[index.item]<timesPerDay){
                    timesCompleteArray[index.item] += 1
                    habitPanels.reloadItems(at: [index])
                    haptic.notificationOccurred(.success) // haptic
                } else {
                    haptic.notificationOccurred(.warning) // haptic
                }
                
                // resaves data
                saveData()
            } else {
                // if edit mode uses manual segue
                performSegue(withIdentifier: "toEditPanel", sender: index)
            }
            
        }
    }
    
    // manual segue to send different data
    @IBAction func addNewHabitTapped(_ sender: Any) {
        performSegue(withIdentifier: "addNewHabit", sender: nil)
    }
    
    // when edit clicked
    @IBAction func editClicked(_ sender: Any) {
        editClicked = !editClicked
        if editClicked{
            editButton.setTitle("Done", for: .normal)
        }else{
            editButton.setTitle("Edit", for: .normal)
        }
        habitPanels.reloadData()
    }
    
    
    
    // exits edit mode when view reloaded from segue
    func editReset(){
        if editClicked{
            editClicked = false
            editButton.setTitle("Edit", for: .normal)
            //habitPanels.reloadData()
        }
    }
    
    // prepare for segue with different cases to send different info
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "addNewHabit"?:
            let dvc = segue.destination as! AddNewHabitScreen
            dvc.habitNamesArray = habitNamesArray
            dvc.timesCompleteArray = timesCompleteArray
            dvc.timesPerDayArray = timesPerDayArray
            dvc.colorsArray = colorsArray
            dvc.palatteIdentifier = palatteIdentifier
        case "toEditPanel"?:
            let dvc = segue.destination as! CellEditingView
            dvc.habitNamesArray = habitNamesArray
            dvc.timesCompleteArray = timesCompleteArray
            dvc.timesPerDayArray = timesPerDayArray
            dvc.colorsArray = colorsArray
            dvc.palatteIdentifier = palatteIdentifier
            dvc.indexOfEdit = sender as! NSIndexPath
        default: break
        }
    }
    
//    @IBAction func leftBarButtonTapped(_ sender: Any) {
//        slideMenuController()?.openLeft()
//    }
    
    
    
    
    
    
    
    // saves data (not date) and makes sure not in edit mode after segue
    @IBAction func unwindToInitialViewController(segue: UIStoryboardSegue){
        saveDataFromOtherView()
        editReset()
    }
    
}

