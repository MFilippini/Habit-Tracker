//
//  AddNewHabitScreen.swift
//  Habit Tracker
//
//  Created by Michael Filippini on 7/7/18.
//  Copyright © 2018 Michael Filippini. All rights reserved.
//

import UIKit

class AddNewHabitScreen: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var colorSelectorCollView: UICollectionView!
    @IBOutlet weak var newHabitNameTextField: UITextField!
    @IBOutlet weak var numberTimesPerDayLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var doneEditingButton: UIButton!
 
    let colorDisplayArray = ["purple","blue","green","yellow","orange","red"]
    
    var selectedColor = "blue"
    var habitName = ""
    var habitPerDay = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorSelectorCollView.dataSource = self
        colorSelectorCollView.delegate = self
        
        stylizeUIElements()
    }
    
    func stylizeUIElements(){
        newHabitNameTextField.layer.borderColor = lightGrey.cgColor
        newHabitNameTextField.layer.borderWidth = 2
        newHabitNameTextField.layer.cornerRadius = 10
        newHabitNameTextField.backgroundColor = darkGrey
        
        saveButton.layer.borderWidth = 2
        saveButton.layer.borderColor = lightGrey.cgColor
        saveButton.backgroundColor = darkGrey
        saveButton.layer.cornerRadius = 23
        
        
        doneEditingButton.layer.borderWidth = 2
        doneEditingButton.layer.borderColor = lightGrey.cgColor
        doneEditingButton.backgroundColor = darkGrey
        doneEditingButton.layer.cornerRadius = 17
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // color selector collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorDisplayArray.count
    } 
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colorSelectorCollView.dequeueReusableCell(withReuseIdentifier: "CellWithColor", for: indexPath) as! ColorCell
        cell.viewForColor.backgroundColor = colors[colorDisplayArray[indexPath.item]]![palatteIdentifier]
        
        return cell
    }
    
    // when color selcted
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 5
        cell?.layer.borderColor = UIColor.white.cgColor
        selectedColor = colorDisplayArray[indexPath.item]
    }
    
    // when color deslected
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 0.5
        cell?.layer.borderColor = lightGrey.cgColor
    }
    
    // pretty done button updates
    @IBAction func textUpdated(_ sender: Any) {
        if newHabitNameTextField.text != ""{
            doneEditingButton.setTitleColor(UIColor.white, for: .normal)

        } else{
            doneEditingButton.setTitleColor(lightGrey, for: .normal)
        }
    }

    // pulls name
    @IBAction func habitNameEntered(_ sender: UITextField) {
        if let nameText = newHabitNameTextField.text{
            habitName = nameText
        }
    }
    
    // plus and minus button
    @IBAction func addTimePerDay(_ sender: Any) {
        numberTimesPerDayLabel.text = String(Int(numberTimesPerDayLabel.text!)! + 1)
        habitPerDay += 1
    }
    
    @IBAction func subtractTimePerDay(_ sender: Any) {
        let number = Int(numberTimesPerDayLabel.text!)!
        if number > 1{
            numberTimesPerDayLabel.text = String(number - 1)
            habitPerDay -= 1
        }
    }
    
    // done button close keyboard
    @IBAction func doneEditingText(_ sender: Any) {
        view.endEditing(true)
    }
    
    // adds habit and segues
    @IBAction func saveClicked(_ sender: UIButton) {
        if habitName != ""{
            habitNamesArray[0].append(habitName)
            timesPerDayArray[0].append(habitPerDay)
            timesCompleteArray[0].append(0)
            colorsArray[0].append(selectedColor)
            performSegue(withIdentifier: "unwindToInitialViewController", sender: self)
        }
    }
    

    
    
}
