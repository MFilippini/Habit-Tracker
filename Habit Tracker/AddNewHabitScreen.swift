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
    
    let colorsArray = [Common.Global.purple,Common.Global.blue,Common.Global.green,Common.Global.yellow,Common.Global.orange,Common.Global.red]
    
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colorSelectorCollView.dequeueReusableCell(withReuseIdentifier: "CellWithColor", for: indexPath) as! ColorCell
        cell.viewForColor.backgroundColor = colorsArray[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 5
        cell?.layer.borderColor = UIColor.white.cgColor
        selectedColor = colorsArray[indexPath.item]
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
    }
    
    @IBAction func subtractTimePerDay(_ sender: Any) {
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
