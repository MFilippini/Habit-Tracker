//
//  PaletteCell.swift
//  Habit Tracker
//
//  Created by Michael Filippini on 7/26/18.
//  Copyright © 2018 Michael Filippini. All rights reserved.
//

import UIKit

class PaletteCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var colorView1: UIView!
    @IBOutlet weak var colorView2: UIView!
    @IBOutlet weak var colorView3: UIView!
    @IBOutlet weak var colorView4: UIView!
    @IBOutlet weak var colorView5: UIView!
    @IBOutlet weak var colorView6: UIView!
    var palette = 0
    override var isSelected: Bool{
        didSet{
            if self.isSelected
            {
                self.layer.borderWidth = 5
                self.layer.borderColor = UIColor.white.cgColor
                print(palette)
                UserDefaults.standard.set(palette, forKey: "palatte")
            }
            else
            {
                self.layer.borderWidth = 0
            }
        }
    }
    
}
