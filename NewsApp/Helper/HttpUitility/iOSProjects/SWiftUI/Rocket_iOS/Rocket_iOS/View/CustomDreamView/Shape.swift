//
//  Shape.swift
//  Rocket_iOS
//
//  Created by Apple on 31/01/22.
//

import Foundation
import SwiftUI


struct ShapeView : Shape{
    
    let bezierPath : UIBezierPath
    let pathbounds : CGRect
    
    func path(in rect: CGRect) -> Path {
        let pointScale = (rect.width >= rect.height ? max(pathbounds.height,pathbounds.width) : min(pathbounds.height , pathbounds.width))
        let pointTransform = CGAffineTransform(scaleX: (1 / pointScale), y: (1 / pointScale))
        let path = Path(bezierPath.cgPath).applying(pointTransform)
        let multiplier = min(rect.width, rect.height)
        let transform = CGAffineTransform(scaleX: multiplier, y: multiplier)
        return path.applying(transform)
    }
    
     
}
