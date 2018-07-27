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

// sea colors
private let purpleSea = UIColor(rgb: 0xaaf09e)
private let blueSea = UIColor(rgb: 0x8edba8)
private let greenSea = UIColor(rgb: 0x68c4af)
private let yellowSea = UIColor(rgb: 0x5e9c9a)
private let orangeSea = UIColor(rgb: 0x3b8686)
private let redSea = UIColor(rgb: 0x0b486b)

// vibrant colors
private let purpleVibrant = UIColor(rgb: 0x6D4483)
private let blueVibrant = UIColor(rgb: 0x4ecdc4)
private let greenVibrant = UIColor(rgb: 0x75efa5)
private let yellowVibrant = UIColor(rgb: 0xd2f481)
private let orangeVibrant = UIColor(rgb: 0xff686b)
private let redVibrant = UIColor(rgb: 0xe23d53)
/*
 
 dictionary values of string colors with color palete values array
 Normal Red = colors["red"][0]
 
 0 : normal
 1 : pastel
 2 : sea
 3 : vibrant
 */

// dev only colors

let lightGrey = UIColor(red: 103/255.0, green: 103/255.0, blue: 103/255.0, alpha: 1)
let darkGrey = UIColor(red: 41/255.0, green: 41/255.0, blue: 41/255.0, alpha: 1)

let palettesTypes = ["Normal Colors","Pastel Colors","Sea Colors","Vibrant Colors"]

let colors = [
    "red":[red,       redPastel,     redSea     ,redVibrant],
    "blue":[blue,     bluePastel,    blueSea    ,blueVibrant],
    "green":[green,   greenPastel,   greenSea   ,greenVibrant],
    "purple":[purple, purplePastel,  purpleSea  ,purpleVibrant],
    "yellow":[yellow, yellowPastel,  yellowSea  ,yellowVibrant],
    "orange":[orange, orangePastel,  orangeSea  ,orangeVibrant]
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


