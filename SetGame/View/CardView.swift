//
//  CardView.swift
//  SetGame
//
//  Created by Aлександр Шаталов on 07/12/2021.
//

import SwiftUI

struct CardView: View {
    
    var id: Int
    var shape: String
    var number: Int
    var color: String
    var shade: String
    var isFaceUp: Bool
    
    
    var opacityOfShape: Double {
        switch shade {
            
        case ShadeOfShape.transparent.rawValue:
            return 0.3
            
        case ShadeOfShape.stroke.rawValue:
            return 1
            
        case ShadeOfShape.filled.rawValue:
            return 1
         
        default:
            return 1
        }
    }

    var shapeColor: Color {
        switch color {
        case ColorOfShape.green.rawValue:
            return Color.green
            
        case ColorOfShape.yellow.rawValue:
            return Color.yellow
            
        case ColorOfShape.red.rawValue:
            return Color.red
            
        default:
            return Color.green
        }
    }
    
    var widthScale: CGFloat {
        switch shape {
        case KindOfShape.triangle.rawValue:
            return widthScaleForCapsuleAndTriangle
            
        case KindOfShape.capsule.rawValue:
            return widthScaleForCapsuleAndTriangle
            
        case KindOfShape.diamond.rawValue:
            return widthScaleForDiamond
        default:
            return widthScaleForCapsuleAndTriangle
        }
    }
    
    var widthScaleForCapsuleAndTriangle: CGFloat {
        switch number {
            case 1:
               return 0.2
            case 2:
                return 0.4
            case 3:
                return 0.6
            default:
                return 0.2
        }
    }
    
    var widthScaleForDiamond: CGFloat {
        switch number {
            case 1:
               return 0.4
            case 2:
                return 0.8
            case 3:
                return 0.9
            default:
                return 0.5
        }
    }

    var body: some View {
        
        GeometryReader { geo in
           
            ZStack {
                
                let shapeRect = RoundedRectangle(cornerRadius: 10)
                
                if isFaceUp == false {
                    shapeRect.fill().foregroundColor(shapeColor)
                    shapeRect.strokeBorder(lineWidth: 3)
                }
                else {
                    shapeRect.fill().foregroundColor(.white)
                    shapeRect.strokeBorder(lineWidth: 3)
                }
                
                VStack {
                    NumberBuilder(number: number, shape: shape, shade: shade)
                    .foregroundColor(shapeColor)
                    .opacity(opacityOfShape)
                    .frame(width: geo.size.width * 0.7,
                           height: geo.size.height * widthScale)
                    .scaledToFit()
                }
            }
        }
         .padding()
        }
        
    }


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(id: 1, shape: "diamand", number: 1, color: "green", shade: "filled", isFaceUp: true)
    }
}
