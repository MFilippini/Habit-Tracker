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
private let green = UIColor(rgb: 0x71eD47)
private let orange = UIColor(rgb: 0xF9A100)
private let yellow = UIColor(rgb: 0xFFF519)

// pastel colors
private let redPastel = UIColor(rgb: 0xF46c67)
private let bluePastel = UIColor(rgb: 0x5ecede)
private let purplePastel = UIColor(rgb: 0xbda6ff)
private let greenPastel = UIColor(rgb: 0x88d9b0)
private let orangePastel = UIColor(rgb: 0xffcb73)
private let yellowPastel = UIColor(rgb: 0xDFF56F)

// dark colors
private let redDark = UIColor(rgb: 0xb95144)
private let blueDark = UIColor(rgb: 0x455899)
private let purpleDark = UIColor(rgb: 0x703a8c)
private let greenDark = UIColor(rgb: 0x59855e)
private let orangeDark = UIColor(rgb: 0xbe795d)
private let yellowDark = UIColor(rgb: 0xae9030)
/*
 
 dictionary values of string colors with color palete values array
 Normal Red = colors["red"][0]
 
 0 : normal
 1 : pastel
 2 : dark
 3 :
 */

// dev only colors

let lightGrey = UIColor(red: 103/255.0, green: 103/255.0, blue: 103/255.0, alpha: 1)
let darkGrey = UIColor(red: 41/255.0, green: 41/255.0, blue: 41/255.0, alpha: 1)

let palettesTypes = ["Normal Colors","Pastel Colors","Dark Colors"]

let colors = [
    "red":[red,redPastel,redDark],
    "blue":[blue,bluePastel,blueDark],
    "green":[green,greenPastel,greenDark],
    "purple":[purple,purplePastel,purpleDark],
    "yellow":[yellow,yellowPastel,yellowDark],
    "orange":[orange,orangePastel,orangeDark]
]




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


