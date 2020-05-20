//
//  colors.swift
//  Abida
//
//  Created by Maisa Ahmad on 5/11/20.
//  Copyright © 2020 Maisa Ahmad. All rights reserved.
//

//Extends UIColor with custom colors
import Foundation
import UIKit

var color1 = UIColor.init(Hex: 0xf2f2f2)
var color2 = UIColor.init(Hex: 0xebd5d5)
var color3 = UIColor.init(Hex: 0xea8a8a)
var color4 = UIColor.init(Hex: 0x685454)

/*Allows usage of hex colors by properly formatting and creating an extension of UIColor*/
extension UIColor{
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(Hex:Int) {
        self.init(red:(Hex >> 16) & 0xff, green:(Hex >> 8) & 0xff, blue:Hex & 0xff)
    }
}
