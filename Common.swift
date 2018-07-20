//
//  Common.swift
//  Habit Tracker
//
//  Created by Michael Filippini on 7/6/18.
//  Copyright © 2018 Michael Filippini. All rights reserved.
//

import UIKit

// basic colors
private let red = UIColor(rgb: 0xFA1C2F)
private let blue = UIColor(rgb: 0x2B88EA)
private let purple = UIColor(rgb: 0xDB12DD)
private let green = UIColor(rgb: 0x71DA47)
private let orange = UIColor(rgb: 0xF9A100)
private let yellow = UIColor(rgb: 0xFFF519)

// pastel colors
private let redPastel = UIColor(rgb: 0xFF5047)
private let bluePastel = UIColor(rgb: 0x6998DD4)
private let purplePastel = UIColor(rgb: 0xCB8ED3)
private let greenPastel = UIColor(rgb: 0x6BD88C)
private let orangePastel = UIColor(rgb: 0xF7A043)
private let yellowPastel = UIColor(rgb: 0xDFF56F)

// spring colors
private let redSpring = UIColor(rgb: 0xF74A26)
private let blueSpring = UIColor(rgb: 0x80DFFC)
private let purpleSpring = UIColor(rgb: 0xA357FF)
private let greenSpring = UIColor(rgb: 0x7FF46B)
private let orangeSpring = UIColor(rgb: 0xFD8835)
private let yellowSpring = UIColor(rgb: 0xF8E328)
/*
 
 dictionary values of string colors with color palete values array
 Normal Red = colors["red"][0]
 
 0 : normal
 1 : pastel
 2 :
 3 :
 */

// dev only colors


let lightGrey = UIColor(red: 103/255.0, green: 103/255.0, blue: 103/255.0, alpha: 1)
let darkGrey = UIColor(red: 41/255.0, green: 41/255.0, blue: 41/255.0, alpha: 1)

let colors = ["red":[red,redPastel,redSpring],"blue":[blue,bluePastel,blueSpring],"green":[green,greenPastel,greenSpring],"purple":[purple,purplePastel,purpleSpring],"yellow":[yellow,yellowPastel,yellowSpring],"orange":[orange,orangePastel,orangeSpring]]




extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    //    let color = UIColor(red: 0xFF, green: 0xFF, blue: 0xFF)
    //    let color2 = UIColor(rgb: 0xFFFFFF)
}


