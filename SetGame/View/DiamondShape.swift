//
//  DiamondShape.swift
//  SetGame
//
//  Created by Aлександр Шаталов on 09/12/2021.
//

import SwiftUI

struct DiamondShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY + rect.maxY/4))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY - rect.maxY/4))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        
        
        return path
    }
    
}


