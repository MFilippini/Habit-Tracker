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
    
    var habitNamesArray: [String] = []
    var timesCompleteArray: [Int] = []
    var colorsArray: [UIColor] = []
    var timesPerDayArray: [Int] = []
    
    let colorDisplayArray = [Common.Global.purple,Common.Global.blue,Common.Global.green,Common.Global.yellow,Common.Global.orange,Common.Global.red]
    
    var selectedColor = Common.Global.blue
    var habitName = ""
    var habitPerDay = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorSelectorCollView.dataSource = self
        colorSelectorCollView.delegate = self
        
        newHabitNameTextField.layer.borderColor = Common.Global.lightGrey.cgColor
        newHabitNameTextField.layer.borderWidth = 2
        newHabitNameTextField.layer.cornerRadius = 10
        newHabitNameTextField.backgroundColor = Common.Global.darkGrey

        saveButton.layer.borderWidth = 2
        saveButton.layer.borderColor = Common.Global.lightGrey.cgColor
        saveButton.backgroundColor = Common.Global.darkGrey
        saveButton.layer.cornerRadius = 26
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorDisplayArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colorSelectorCollView.dequeueReusableCell(withReuseIdentifier: "CellWithColor", for: indexPath) as! ColorCell
        cell.viewForColor.backgroundColor = colorDisplayArray[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 5
        cell?.layer.borderColor = UIColor.white.cgColor
        selectedColor = colorDisplayArray[indexPath.item]
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 0.5
        cell?.layer.borderColor = Common.Global.lightGrey.cgColor
    }
    
    
    @IBAction func habitNameEntered(_ sender: UITextField) {
        if let nameText = newHabitNameTextField.text{
            habitName = nameText
        }
    }
    
    
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
    
    @IBAction func saveClicked(_ sender: UIButton) {
        if habitName != ""{
            habitNamesArray.append(habitName)
            timesPerDayArray.append(habitPerDay)
            timesCompleteArray.append(0)
            colorsArray.append(selectedColor)
            dismiss(animated: true, completion: nil)
        }
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! ViewController
        dvc.habitNamesArray = habitNamesArray
        dvc.timesCompleteArray = timesCompleteArray
        dvc.timesPerDayArray = timesPerDayArray
        dvc.colorsArray = colorsArray
     }
    
    
}
