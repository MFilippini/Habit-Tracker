//
//  AllHabitsDisplayCell.swift
//  Habit Tracker
//
//  Created by Michael Filippini on 6/3/19.
//  Copyright © 2019 Michael Filippini. All rights reserved.
//

import UIKit

class AllHabitsDisplayCell: UICollectionViewCell,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var habitPanels: UICollectionView!
    
    override func awakeFromNib() {
        habitPanels.dataSource = self
        habitPanels.delegate = self
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
        outsideRing.lineCap = CAShapeLayerLineCap.round
        
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
        let progressPercent = Float32(timesCompleteArray[0][indexOfCell]) / Float32(timesPerDayArray[0][indexOfCell])
        
        progressBarAnimate.toValue = CGFloat(progressPercent)
        progressBarAnimate.duration = 0.7
        ring.strokeColor = colors[colorsArray[0][indexOfCell]]![palatteIdentifier].cgColor
        progressBarAnimate.isRemovedOnCompletion = false
        progressBarAnimate.fillMode = CAMediaTimingFillMode.forwards
        
        ring.add(progressBarAnimate,forKey: nil)
    }
    
    // collection view setup
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return habitNamesArray[0].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = habitPanels.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HabitCell
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        
        // changes text when edit mode is on
        if !editOn{
            cell.labelHabitName.text = habitNamesArray[0][indexPath.item]
        } else {
            cell.labelHabitName.text = ("Edit: "+habitNamesArray[0][indexPath.item])
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
            
            if(!editOn){
                haptic.prepare() // prepare haptic
                let timesPerDay = timesPerDayArray[0][index.item]
                
                // asks if can increment times complete
                if (timesCompleteArray[0][index.item]<timesPerDay){
                    timesCompleteArray[0][index.item] += 1
                    habitPanels.reloadItems(at: [index])
                    haptic.notificationOccurred(.success) // haptic
                } else {
                    haptic.notificationOccurred(.warning) // haptic
                }
                
                // resaves data
                UserDefaults.standard.set(habitNamesArray, forKey: "habitNames")
                UserDefaults.standard.set(timesCompleteArray, forKey: "timesComplete")
                UserDefaults.standard.set(colorsArray, forKey: "colors")
                UserDefaults.standard.set(timesPerDayArray, forKey: "timesADay")
                UserDefaults.standard.set(palatteIdentifier, forKey: "palatte")
            } else {
                // if edit mode uses manual segue
                //ViewController().performSegue(withIdentifier: "toEditPanel", sender: index)
            }
            
        }
    }
    
    
}
