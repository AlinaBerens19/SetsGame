//
//  Theme.swift
//  SetGame
//
//  Created by Aлександр Шаталов on 05/12/2021.
//

import Foundation



struct CreateNewTheme {
  
    var themes = [Theme]()
    var i = 0
    
    init() {
        createTheme()
        for theme in themes {
            i += 1
            print("Theme #\(i): \(theme)")
        }
        print("Count \(themes.count)")
    }
    
    mutating func createTheme() {
        for number in NumberOfShapes.values {
            for color in ColorOfShape.values {
                for shape in KindOfShape.values {
                    for shade in ShadeOfShape.values {
                        let theme = Theme(number: number, shape: shape, color: color, shade: shade)
                        themes.append(theme)
                    }
                }
            }
        }
    }
}


struct Theme: Equatable {
  
    static func == (lhs: Theme, rhs: Theme) -> Bool {
        return lhs.number.rawValue != rhs.number.rawValue &&
        lhs.shape.rawValue != rhs.shape.rawValue &&
        lhs.color.rawValue != rhs.color.rawValue &&
        lhs.shade.rawValue != rhs.shade.rawValue
   
        
    }

    var number: NumberOfShapes = .one
    var shape: KindOfShape = .capsule
    var color: ColorOfShape = .red
    var shade: ShadeOfShape = .filled
    
}

