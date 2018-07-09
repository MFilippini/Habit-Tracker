//
//  CellEditingView.swift
//  Habit Tracker
//
//  Created by Michael Filippini on 7/8/18.
//  Copyright © 2018 Michael Filippini. All rights reserved.
//

import UIKit

class CellEditingView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var renameHabitTextField: UITextField!
    @IBOutlet weak var renameDoneButton: UIButton!
    @IBOutlet weak var timesPerDayLabel: UILabel!
    @IBOutlet weak var timesCompletedTodayLabel: UILabel!
    @IBOutlet weak var colorSelectEdit: UICollectionView!
    @IBOutlet weak var saveChangesButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var habitNamesArray: [String] = []
    var timesCompleteArray: [Int] = []
    var colorsArray: [UIColor] = []
    var timesPerDayArray: [Int] = []
    var indexOfEdit = NSIndexPath()
    
    let colorDisplayArray = [Common.Global.purple,Common.Global.blue,Common.Global.green,Common.Global.yellow,Common.Global.orange,Common.Global.red]
    
    var selectedColor = Common.Global.blue
    var habitName = ""
    var habitPerDay = 1
    var habitCurrent = 1
    var selectedColorLocation = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateWithCorrectValues()
        colorSelectEdit.dataSource = self
        colorSelectEdit.delegate = self
        
        stylizeUIElements()
    }
    
    func stylizeUIElements(){
        renameHabitTextField.layer.borderColor = Common.Global.lightGrey.cgColor
        renameHabitTextField.layer.borderWidth = 2
        renameHabitTextField.layer.cornerRadius = 10
        renameHabitTextField.backgroundColor = Common.Global.darkGrey
        
        saveChangesButton.layer.borderWidth = 2
        saveChangesButton.layer.borderColor = Common.Global.lightGrey.cgColor
        saveChangesButton.backgroundColor = Common.Global.darkGrey
        saveChangesButton.layer.cornerRadius = 26
        
        deleteButton.layer.borderWidth = 2
        deleteButton.layer.borderColor = Common.Global.lightGrey.cgColor
        deleteButton.backgroundColor = Common.Global.darkGrey
        deleteButton.layer.cornerRadius = 26
        
        renameDoneButton.layer.borderWidth = 2
        renameDoneButton.layer.borderColor = Common.Global.lightGrey.cgColor
        renameDoneButton.backgroundColor = Common.Global.darkGrey
        renameDoneButton.layer.cornerRadius = 17
    }
    
    // manual select of color becuase UIColectionViews are annoying
    override func viewDidAppear(_ animated: Bool) {
        colorSelectEdit.cellForItem(at: NSIndexPath(item: selectedColorLocation, section: 0) as IndexPath)?.layer.borderWidth = 5
        colorSelectEdit.cellForItem(at: NSIndexPath(item: selectedColorLocation, section: 0) as IndexPath)?.layer.borderColor = UIColor.white.cgColor
    }
    
    // fills edit scrren with correct data
    func updateWithCorrectValues(){
  
        selectedColor = colorsArray[indexOfEdit.item]
        habitName = habitNamesArray[indexOfEdit.item]
        habitPerDay = timesPerDayArray[indexOfEdit.item]
        habitCurrent = timesCompleteArray[indexOfEdit.item]
        
        renameHabitTextField.text = habitName
        timesPerDayLabel.text = String(habitPerDay)
        timesCompletedTodayLabel.text = String(habitCurrent)
        selectedColorLocation = colorDisplayArray.index(of: selectedColor)!
        renameDoneButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // setup collection view for color select
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorDisplayArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colorSelectEdit.dequeueReusableCell(withReuseIdentifier: "CellWithColor", for: indexPath) as! ColorCell
        cell.viewForColor.backgroundColor = colorDisplayArray[indexPath.item]
        return cell
    }
    
    // select of colletion view with extra code becuse collection views are mean
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        colorSelectEdit.cellForItem(at: NSIndexPath(item: selectedColorLocation, section: 0) as IndexPath)?.layer.borderWidth = 0.5
        colorSelectEdit.cellForItem(at: NSIndexPath(item: selectedColorLocation, section: 0) as IndexPath)?.layer.borderColor = Common.Global.lightGrey.cgColor
        cell?.layer.borderWidth = 5
        cell?.layer.borderColor = UIColor.white.cgColor
        selectedColor = colorDisplayArray[indexPath.item]
    }
    
    // deseleect collection view
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 0.5
        cell?.layer.borderColor = Common.Global.lightGrey.cgColor
        
    }
    
    // done button pulls text
    @IBAction func pullNewText(_ sender: UITextField) {
        if let nameText = renameHabitTextField.text{
            habitName = nameText
        }
    }
    
    // makes button look nice and update
    @IBAction func updateDoneButton(_ sender: UITextField) {
        if renameHabitTextField.text != ""{
            renameDoneButton.setTitleColor(UIColor.white, for: .normal)
            
        } else{
            renameDoneButton.setTitleColor(Common.Global.lightGrey, for: .normal)
        }
    }
    
    // tap scrren to close keyboard was conflicting with color select so this :(
    @IBAction func finishCloseKeyboard(_ sender: UIButton) {
        view.endEditing(true)
    }
    
    // makes buttons work and avoids people messing stuff up
    @IBAction func subtractPerDay(_ sender: UIButton) {
        let number = Int(timesPerDayLabel.text!)!
        if number > 1{
            timesPerDayLabel.text = String(number - 1)
            habitPerDay -= 1
            
            let numberToday = Int(timesCompletedTodayLabel.text!)!
            if numberToday == number {
                timesCompletedTodayLabel.text = String(number - 1)
                habitCurrent -= 1
            }
        }
    }
    
    @IBAction func addPerDay(_ sender: UIButton) {
        timesPerDayLabel.text = String(Int(timesPerDayLabel.text!)! + 1)
        habitPerDay += 1
    }
    
    
    @IBAction func subtractToday(_ sender: UIButton) {
        let number = Int(timesCompletedTodayLabel.text!)!
        if number > 0{
            timesCompletedTodayLabel.text = String(number - 1)
            habitCurrent -= 1
        }
    }
    
    @IBAction func addToday(_ sender: UIButton) {
        let number = Int(timesCompletedTodayLabel.text!)!
        if number < habitPerDay{
            timesCompletedTodayLabel.text = String(number + 1)
            habitCurrent += 1
        }
    }
    
    
    // segue when delete clicked
    @IBAction func deleteClicked(_ sender: Any) {
        habitNamesArray.remove(at: indexOfEdit.item)
        timesPerDayArray.remove(at: indexOfEdit.item)
        timesCompleteArray.remove(at: indexOfEdit.item)
        colorsArray.remove(at: indexOfEdit.item)
        
        performSegue(withIdentifier: "unwindToInitialViewController2", sender: self)
    }
    
    // segue when save clicked
   @IBAction func saveAndFinish(_ sender: UIButton) {
       if habitName != ""{
        habitNamesArray[indexOfEdit.item] = habitName
        timesPerDayArray[indexOfEdit.item] = habitPerDay
        timesCompleteArray[indexOfEdit.item] = habitCurrent
        colorsArray[indexOfEdit.item] = selectedColor
        
        performSegue(withIdentifier: "unwindToInitialViewController2", sender: self)
        }
    }
    
    // data passed back to beginning
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! ViewController
        dvc.habitNamesArray = habitNamesArray
        dvc.timesPerDayArray = timesPerDayArray
        dvc.timesCompleteArray = timesCompleteArray
        dvc.colorsArray  = colorsArray
    }
    
}
