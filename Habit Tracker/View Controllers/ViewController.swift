//
//  ViewController.swift
//  Habit Tracker
//
//  Created by Michael Filippini on 7/5/18.
//  Copyright © 2018 Michael Filippini. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CollectionEditDelegate {
    
    @IBOutlet weak var allHabitDisplays: UICollectionView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    
    // First Time Opening App Preset Habits
//    var habitNamesArray: [String] = ["Walk the Dog","Workout","Meditate","Drink Water"]
//    var timesCompleteArray: [Int] = [1,1,2,3]
//    var colorsArray = ["red","orange","purple","blue"]
//    var timesPerDayArray: [Int] = [3,2,4,8]
//    var palatteIdentifier = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarItem()
        
        allHabitDisplays.dataSource = self
        allHabitDisplays.delegate = self
        
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
        
        print(habitNamesArray)
        
        
        if let savedNames = UserDefaults.standard.object(forKey: "habitNames") as? Array<String>{
            habitNamesArray[0] = savedNames
        }
        if let savedColors = UserDefaults.standard.object(forKey: "colors") as? Array<String>{
            colorsArray[0] = savedColors
        }
        if let savedPerDay = UserDefaults.standard.object(forKey: "timesADay") as? Array<Int>{
            timesPerDayArray[0] = savedPerDay
        }
        if let palatte = UserDefaults.standard.object(forKey: "palatte") as? Int{
            palatteIdentifier = palatte
        }

        if let savedCompletions = UserDefaults.standard.object(forKey: "timesComplete") as? Array<Int>{
            timesCompleteArray[0] = savedCompletions
            if let day = UserDefaults.standard.object(forKey: "lastDay") as? String{
                let cal = Calendar.current
                if(day != "\(cal.component(.day, from: Date())):\(cal.component(.month, from: Date())):\(cal.component(.year, from: Date()))"){
                    timesCompleteArray.removeAll()
                    for _ in savedCompletions{
                        timesCompleteArray[0].append(0)
                    }
                    saveData()
                }
            }
        }
        allHabitDisplays.reloadData()
    }
    
    
    //saves data
    func saveData(){
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
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = allHabitDisplays.dequeueReusableCell(withReuseIdentifier: "DisplayCell", for: indexPath) as! AllHabitsDisplayCell
        
        cell.awakeFromNib()
        
        if(indexPath.item == 0){
            cell.title.text = "Daily Goals"
        }else if(indexPath.item == 1){
            cell.title.text = "Weekly Goals"
        }else if(indexPath.item == 2){
            cell.title.text = "Monthly Goals"
        }
        
        cell.habitPanels.reloadData()
        cell.editDelegate = self
        
        return cell
    }
    
    // manual segue to send different data
    @IBAction func addNewHabitTapped(_ sender: Any) {
        performSegue(withIdentifier: "addNewHabit", sender: nil)
    }
    
    
    // when edit clicked
    @IBAction func editClicked(_ sender: Any) {
        editOn = !editOn
        if editOn{
            editButton.setTitle("Done", for: .normal)
        }else{
            editButton.setTitle("Edit", for: .normal)
        }
        allHabitDisplays.reloadData()
    }
    
    
    // exits edit mode when view reloaded from segue
    func editReset(){
        if editOn{
            editOn = false
            editButton.setTitle("Edit", for: .normal)
            allHabitDisplays.reloadData()
        }
    }
    
    // prepare for segue with different cases to send different info
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toEditPanel"){
            let dvc = segue.destination as! CellEditingView
            dvc.indexOfEdit = sender as! NSIndexPath
        }
    }
    
    func editMode(index: NSIndexPath) {
        performSegue(withIdentifier: "toEditPanel", sender: index)
    }

    
    
    // saves data (not date) and makes sure not in edit mode after segue
    @IBAction func unwindToInitialViewController(segue: UIStoryboardSegue){
        saveDataFromOtherView()
        editReset()
    }
    
}

