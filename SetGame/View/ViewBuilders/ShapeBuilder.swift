//
//  ShapeBuilder.swift
//  SetGame
//
//  Created by Aлександр Шаталов on 14/12/2021.
//

import SwiftUI

struct ShapeBuilder: View {

    var shape: String
    var shade: String
    
    var strokeOrFilled: Bool {
        switch shade {
            
        case ShadeOfShape.transparent.rawValue:
            return true
            
        case ShadeOfShape.stroke.rawValue:
            return false
            
        case ShadeOfShape.filled.rawValue:
            return true
         
        default:
            return true
        }
    }

    var body: some View {
        
      switch self.shape {
          
        case KindOfShape.diamond.rawValue:
          if strokeOrFilled {
              DiamondShape()
          }
          else {
              DiamondShape().stroke(lineWidth: 2)
          }
           
        case KindOfShape.triangle.rawValue:
          if strokeOrFilled {
              Squiggle()
          }
          else {
              Squiggle().stroke(lineWidth: 2)
          }
            
        case KindOfShape.capsule.rawValue:
          if strokeOrFilled {
              Capsule()
          }
          else {
              Capsule().stroke(lineWidth: 2)
          }
             
        default:
             DiamondShape()
          
        }
    }
}

