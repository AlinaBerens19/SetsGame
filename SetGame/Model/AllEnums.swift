//
//  AllEnums.swift
//  SetGame
//
//  Created by Aлександр Шаталов on 14/12/2021.
//

import Foundation



enum NumberOfShapes: Int {
    case one = 1, two, three
    static let values = [one, two, three]
    }
    
enum KindOfShape: String {
    case diamond, triangle, capsule
    static let values = [diamond, triangle, capsule]
    }

enum ColorOfShape: String {
    case green, yellow, red
    static let values = [green, yellow, red]
    }

enum ShadeOfShape: String {
    case filled, stroke, transparent
    static let values = [filled, stroke, transparent]
    }
