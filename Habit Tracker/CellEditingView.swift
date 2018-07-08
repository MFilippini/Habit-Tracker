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
    
    let colorDisplayArray = [Common.Global.purple,Common.Global.blue,Common.Global.green,Common.Global.yellow,Common.Global.orange,Common.Global.red]
    
    var selectedColor = Common.Global.blue
    var habitName = ""
    var habitPerDay = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorSelectEdit.dataSource = self
        colorSelectEdit.delegate = self
        
        renameHabitTextField.layer.borderColor = Common.Global.lightGrey.cgColor
        renameHabitTextField.layer.borderWidth = 2
        renameHabitTextField.layer.cornerRadius = 10
        renameHabitTextField.backgroundColor = Common.Global.darkGrey
        
        saveChangesButton.layer.borderWidth = 2
        saveChangesButton.layer.borderColor = Common.Global.lightGrey.cgColor
        saveChangesButton.backgroundColor = Common.Global.darkGrey
        saveChangesButton.layer.cornerRadius = 26
        
        renameDoneButton.layer.borderWidth = 2
        renameDoneButton.layer.borderColor = Common.Global.lightGrey.cgColor
        renameDoneButton.backgroundColor = Common.Global.darkGrey
        renameDoneButton.layer.cornerRadius = 17
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorDisplayArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colorSelectEdit.dequeueReusableCell(withReuseIdentifier: "CellWithColor", for: indexPath) as! ColorCell
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
    
    
    @IBAction func pullNewText(_ sender: UITextField) {
        if let nameText = renameHabitTextField.text{
            habitName = nameText
        }
    }
    
    @IBAction func updateDoneButton(_ sender: UITextField) {
        if renameHabitTextField.text != ""{
            renameDoneButton.setTitleColor(UIColor.white, for: .normal)
            
        } else{
            renameDoneButton.setTitleColor(Common.Global.lightGrey, for: .normal)
        }
    }
    
    @IBAction func finishCloseKeyboard(_ sender: UIButton) {
        view.endEditing(true)
    }
    
    
    @IBAction func subtractPerDay(_ sender: UIButton) {
        let number = Int(timesPerDayLabel.text!)!
        if number > 1{
            timesPerDayLabel.text = String(number - 1)
            habitPerDay -= 1
        }
    }
    @IBAction func addPerDay(_ sender: UIButton) {
        timesPerDayLabel.text = String(Int(timesPerDayLabel.text!)! + 1)
        habitPerDay += 1
    }
    
    
    @IBAction func subtractToday(_ sender: UIButton) {
        let number = Int(timesCompletedTodayLabel.text!)!
        if number > 1 && number < 6/*possible total for day*/{
            timesCompletedTodayLabel.text = String(number - 1)
            habitPerDay -= 1
        }
    }
    
    @IBAction func addToday(_ sender: UIButton) {
        timesCompletedTodayLabel.text = String(Int(timesCompletedTodayLabel.text!)! + 1)
        habitPerDay += 1
    }
    
    
    
//    @IBAction func saveAndFinish(_ sender: UIButton) {
//        if habitName != ""{
//            habitNamesArray.append(habitName)
//            timesPerDayArray.append(habitPerDay)
//            timesCompleteArray.append(0)
//            colorsArray.append(selectedColor)
//            performSegue(withIdentifier: "unwindToInitialViewController", sender: self)
//        }
//    }
    
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
}
