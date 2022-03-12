//
//  UIBezierPath + Extension.swift
//  Rocket_iOS
//
//  Created by Apple on 31/01/22.
//

import Foundation
import UIKit

//public extension UIBezierPath {
//    
//    /**
//     Parses a single path string. Parses synchronously.
//     - Parameter pathString: The path `d` string to parse.
//     */
//    convenience init(pathString: String) {
//        let singlePath = SVGPath(singlePathString: pathString)
//        guard let cgPath = singlePath.svgLayer.path else {
//            self.init()
//            return
//        }
//        #if os(iOS) || os(tvOS)
//        self.init(cgPath: cgPath)
//        #elseif os(OSX)
//        self.init()
//        #endif
//    }
//    
//    /// :nodoc:
//    @available(*, deprecated, message: "This method is deprecated. If you want to parse a single path, instantiate a new instance of SVGPath using the SVGPath(singlePathString:) initializer and pass the path string.")
//    class func pathWithSVGURL(_ SVGURL: URL) -> UIBezierPath? {
//        assert(false, "This method is deprecated")
//        return nil
//    }
//    
//}


//extension UIBezierPath {
//    static func calculateBounds(paths : [UIBezierPath]) -> CGRect{
//        let myPaths = UIBezierPath()
//        for path in paths{
//            myPaths.append(path)
//        }
//        return (myPaths.bounds)
//    }
//
//    static var customDottedShape : UIBezierPath {
//        let bezierPath = UIBezierPath()
//        bezierPath.move(to: CGPoint(x: 31.19, y: 94))
//        bezierPath.addLine(to: CGPoint(x: 29.96, y: 94))
//        bezierPath.addLine(to: CGPoint(x: 29.96, y: 84.14))
//        bezierPath.addLine(to: CGPoint(x: 35.95, y: 84.14))
//        bezierPath.addLine(to: CGPoint(x: 35.95, y: 85.24))
//        bezierPath.addLine(to: CGPoint(x: 31.19, y: 85.24))
//        bezierPath.addLine(to: CGPoint(x: 31.19, y: 88.63))
//        bezierPath.addLine(to: CGPoint(x: 35.56, y: 88.63))
//        bezierPath.addLine(to: CGPoint(x: 35.56, y: 89.73))
//        bezierPath.addLine(to: CGPoint(x: 31.19, y: 89.73))
//        bezierPath.addLine(to: CGPoint(x: 31.19, y: 94))
//        bezierPath.close()
//        bezierPath.move(to: CGPoint(x: 39.84, y: 94.12))
//        bezierPath.addCurve(to: CGPoint(x: 37.45, y: 93.13), controlPoint1: CGPoint(x: 38.85, y: 94.12), controlPoint2: CGPoint(x: 38.05, y: 93.79))
//        bezierPath.addCurve(to: CGPoint(x: 36.55, y: 90.45), controlPoint1: CGPoint(x: 36.85, y: 92.47), controlPoint2: CGPoint(x: 36.55, y: 91.57))
//        bezierPath.addCurve(to: CGPoint(x: 37.45, y: 87.77), controlPoint1: CGPoint(x: 36.55, y: 89.32), controlPoint2: CGPoint(x: 36.85, y: 88.43))
//        bezierPath.addCurve(to: CGPoint(x: 39.84, y: 86.77), controlPoint1: CGPoint(x: 38.05, y: 87.1), controlPoint2: CGPoint(x: 38.85, y: 86.77))
//        bezierPath.addCurve(to: CGPoint(x: 42.23, y: 87.77), controlPoint1: CGPoint(x: 40.83, y: 86.77), controlPoint2: CGPoint(x: 41.63, y: 87.1))
//        bezierPath.addCurve(to: CGPoint(x: 43.13, y: 90.45), controlPoint1: CGPoint(x: 42.83, y: 88.43), controlPoint2: CGPoint(x: 43.13, y: 89.32))
//        bezierPath.addCurve(to: CGPoint(x: 42.23, y: 93.12), controlPoint1: CGPoint(x: 43.13, y: 91.57), controlPoint2: CGPoint(x: 42.83, y: 92.46))
//        bezierPath.addCurve(to: CGPoint(x: 39.84, y: 94.12), controlPoint1: CGPoint(x: 41.63, y: 93.79), controlPoint2: CGPoint(x: 40.83, y: 94.12))
//        bezierPath.close()
//        bezierPath.move(to: CGPoint(x: 38.32, y: 92.38))
//        bezierPath.addCurve(to: CGPoint(x: 39.84, y: 93.08), controlPoint1: CGPoint(x: 38.7, y: 92.84), controlPoint2: CGPoint(x: 39.2, y: 93.08))
//        bezierPath.addCurve(to: CGPoint(x: 41.36, y: 92.39), controlPoint1: CGPoint(x: 40.48, y: 93.08), controlPoint2: CGPoint(x: 40.99, y: 92.85))
//        bezierPath.addCurve(to: CGPoint(x: 41.92, y: 90.45), controlPoint1: CGPoint(x: 41.73, y: 91.92), controlPoint2: CGPoint(x: 41.92, y: 91.27))
//        bezierPath.addCurve(to: CGPoint(x: 41.36, y: 88.51), controlPoint1: CGPoint(x: 41.92, y: 89.62), controlPoint2: CGPoint(x: 41.73, y: 88.97))
//        bezierPath.addCurve(to: CGPoint(x: 39.84, y: 87.81), controlPoint1: CGPoint(x: 40.99, y: 88.05), controlPoint2: CGPoint(x: 40.48, y: 87.81))
//        bezierPath.addCurve(to: CGPoint(x: 38.32, y: 88.51), controlPoint1: CGPoint(x: 39.2, y: 87.81), controlPoint2: CGPoint(x: 38.7, y: 88.05))
//        bezierPath.addCurve(to: CGPoint(x: 37.76, y: 90.45), controlPoint1: CGPoint(x: 37.94, y: 88.98), controlPoint2: CGPoint(x: 37.76, y: 89.62))
//        bezierPath.addCurve(to: CGPoint(x: 38.32, y: 92.38), controlPoint1: CGPoint(x: 37.76, y: 91.27), controlPoint2: CGPoint(x: 37.94, y: 91.92))
//        bezierPath.close()
//        bezierPath.move(to: CGPoint(x: 44.72, y: 85.17))
//        bezierPath.addLine(to: CGPoint(x: 45.91, y: 85.17))
//        bezierPath.addLine(to: CGPoint(x: 45.91, y: 86.89))
//        bezierPath.addLine(to: CGPoint(x: 47.29, y: 86.89))
//        bezierPath.addLine(to: CGPoint(x: 47.29, y: 87.87))
//        bezierPath.addLine(to: CGPoint(x: 45.91, y: 87.87))
//        bezierPath.addLine(to: CGPoint(x: 45.91, y: 92.09))
//        bezierPath.addCurve(to: CGPoint(x: 46.12, y: 92.81), controlPoint1: CGPoint(x: 45.91, y: 92.42), controlPoint2: CGPoint(x: 45.98, y: 92.66))
//        bezierPath.addCurve(to: CGPoint(x: 46.79, y: 93.04), controlPoint1: CGPoint(x: 46.26, y: 92.96), controlPoint2: CGPoint(x: 46.48, y: 93.04))
//        bezierPath.addCurve(to: CGPoint(x: 47.28, y: 93), controlPoint1: CGPoint(x: 46.98, y: 93.04), controlPoint2: CGPoint(x: 47.14, y: 93.02))
//        bezierPath.addLine(to: CGPoint(x: 47.28, y: 94))
//        bezierPath.addCurve(to: CGPoint(x: 46.53, y: 94.05), controlPoint1: CGPoint(x: 47.12, y: 94.04), controlPoint2: CGPoint(x: 46.87, y: 94.05))
//        bezierPath.addCurve(to: CGPoint(x: 45.13, y: 93.62), controlPoint1: CGPoint(x: 45.88, y: 94.05), controlPoint2: CGPoint(x: 45.41, y: 93.91))
//        bezierPath.addCurve(to: CGPoint(x: 44.72, y: 92.15), controlPoint1: CGPoint(x: 44.85, y: 93.33), controlPoint2: CGPoint(x: 44.72, y: 92.84))
//        bezierPath.addLine(to: CGPoint(x: 44.72, y: 87.87))
//        bezierPath.addLine(to: CGPoint(x: 43.66, y: 87.87))
//        bezierPath.addLine(to: CGPoint(x: 43.66, y: 86.89))
//        bezierPath.addLine(to: CGPoint(x: 44.72, y: 86.89))
//        bezierPath.addLine(to: CGPoint(x: 44.72, y: 85.17))
//        bezierPath.close()
//        bezierPath.move(to: CGPoint(x: 51.3, y: 94.12))
//        bezierPath.addCurve(to: CGPoint(x: 48.91, y: 93.13), controlPoint1: CGPoint(x: 50.31, y: 94.12), controlPoint2: CGPoint(x: 49.51, y: 93.79))
//        bezierPath.addCurve(to: CGPoint(x: 48, y: 90.45), controlPoint1: CGPoint(x: 48.3, y: 92.47), controlPoint2: CGPoint(x: 48, y: 91.57))
//        bezierPath.addCurve(to: CGPoint(x: 48.91, y: 87.77), controlPoint1: CGPoint(x: 48, y: 89.32), controlPoint2: CGPoint(x: 48.3, y: 88.43))
//        bezierPath.addCurve(to: CGPoint(x: 51.3, y: 86.77), controlPoint1: CGPoint(x: 49.51, y: 87.1), controlPoint2: CGPoint(x: 50.31, y: 86.77))
//        bezierPath.addCurve(to: CGPoint(x: 53.68, y: 87.77), controlPoint1: CGPoint(x: 52.29, y: 86.77), controlPoint2: CGPoint(x: 53.08, y: 87.1))
//        bezierPath.addCurve(to: CGPoint(x: 54.59, y: 90.45), controlPoint1: CGPoint(x: 54.29, y: 88.43), controlPoint2: CGPoint(x: 54.59, y: 89.32))
//        bezierPath.addCurve(to: CGPoint(x: 53.68, y: 93.12), controlPoint1: CGPoint(x: 54.59, y: 91.57), controlPoint2: CGPoint(x: 54.29, y: 92.46))
//        bezierPath.addCurve(to: CGPoint(x: 51.3, y: 94.12), controlPoint1: CGPoint(x: 53.08, y: 93.79), controlPoint2: CGPoint(x: 52.29, y: 94.12))
//        bezierPath.close()
//        bezierPath.move(to: CGPoint(x: 49.77, y: 92.38))
//        bezierPath.addCurve(to: CGPoint(x: 51.3, y: 93.08), controlPoint1: CGPoint(x: 50.15, y: 92.84), controlPoint2: CGPoint(x: 50.66, y: 93.08))
//        bezierPath.addCurve(to: CGPoint(x: 52.82, y: 92.39), controlPoint1: CGPoint(x: 51.94, y: 93.08), controlPoint2: CGPoint(x: 52.44, y: 92.85))
//        bezierPath.addCurve(to: CGPoint(x: 53.38, y: 90.45), controlPoint1: CGPoint(x: 53.19, y: 91.92), controlPoint2: CGPoint(x: 53.38, y: 91.27))
//        bezierPath.addCurve(to: CGPoint(x: 52.82, y: 88.51), controlPoint1: CGPoint(x: 53.38, y: 89.62), controlPoint2: CGPoint(x: 53.19, y: 88.97))
//        bezierPath.addCurve(to: CGPoint(x: 51.3, y: 87.81), controlPoint1: CGPoint(x: 52.44, y: 88.05), controlPoint2: CGPoint(x: 51.94, y: 87.81))
//        bezierPath.addCurve(to: CGPoint(x: 49.77, y: 88.51), controlPoint1: CGPoint(x: 50.66, y: 87.81), controlPoint2: CGPoint(x: 50.15, y: 88.05))
//        bezierPath.addCurve(to: CGPoint(x: 49.21, y: 90.45), controlPoint1: CGPoint(x: 49.4, y: 88.98), controlPoint2: CGPoint(x: 49.21, y: 89.62))
//        bezierPath.addCurve(to: CGPoint(x: 49.77, y: 92.38), controlPoint1: CGPoint(x: 49.21, y: 91.27), controlPoint2: CGPoint(x: 49.4, y: 91.92))
//        bezierPath.close()
//        bezierPath.move(to: CGPoint(x: 60.08, y: 94))
//        bezierPath.addLine(to: CGPoint(x: 58.85, y: 94))
//        bezierPath.addLine(to: CGPoint(x: 58.85, y: 84.14))
//        bezierPath.addLine(to: CGPoint(x: 60.08, y: 84.14))
//        bezierPath.addLine(to: CGPoint(x: 60.08, y: 94))
//        bezierPath.close()
//        bezierPath.move(to: CGPoint(x: 61.81, y: 94))
//        bezierPath.addLine(to: CGPoint(x: 61.81, y: 86.89))
//        bezierPath.addLine(to: CGPoint(x: 62.93, y: 86.89))
//        bezierPath.addLine(to: CGPoint(x: 62.93, y: 88.03))
//        bezierPath.addLine(to: CGPoint(x: 62.95, y: 88.03))
//        bezierPath.addCurve(to: CGPoint(x: 63.74, y: 87.11), controlPoint1: CGPoint(x: 63.13, y: 87.64), controlPoint2: CGPoint(x: 63.39, y: 87.33))
//        bezierPath.addCurve(to: CGPoint(x: 64.97, y: 86.77), controlPoint1: CGPoint(x: 64.09, y: 86.88), controlPoint2: CGPoint(x: 64.5, y: 86.77))
//        bezierPath.addCurve(to: CGPoint(x: 66.21, y: 87.12), controlPoint1: CGPoint(x: 65.45, y: 86.77), controlPoint2: CGPoint(x: 65.87, y: 86.89))
//        bezierPath.addCurve(to: CGPoint(x: 66.97, y: 88.12), controlPoint1: CGPoint(x: 66.56, y: 87.36), controlPoint2: CGPoint(x: 66.81, y: 87.69))
//        bezierPath.addLine(to: CGPoint(x: 66.99, y: 88.12))
//        bezierPath.addCurve(to: CGPoint(x: 67.88, y: 87.13), controlPoint1: CGPoint(x: 67.19, y: 87.7), controlPoint2: CGPoint(x: 67.48, y: 87.37))
//        bezierPath.addCurve(to: CGPoint(x: 69.22, y: 86.77), controlPoint1: CGPoint(x: 68.27, y: 86.89), controlPoint2: CGPoint(x: 68.72, y: 86.77))
//        bezierPath.addCurve(to: CGPoint(x: 70.9, y: 87.4), controlPoint1: CGPoint(x: 69.92, y: 86.77), controlPoint2: CGPoint(x: 70.48, y: 86.98))
//        bezierPath.addCurve(to: CGPoint(x: 71.54, y: 89.09), controlPoint1: CGPoint(x: 71.33, y: 87.82), controlPoint2: CGPoint(x: 71.54, y: 88.39))
//        bezierPath.addLine(to: CGPoint(x: 71.54, y: 94))
//        bezierPath.addLine(to: CGPoint(x: 70.35, y: 94))
//        bezierPath.addLine(to: CGPoint(x: 70.35, y: 89.37))
//        bezierPath.addCurve(to: CGPoint(x: 69.96, y: 88.23), controlPoint1: CGPoint(x: 70.35, y: 88.88), controlPoint2: CGPoint(x: 70.22, y: 88.5))
//        bezierPath.addCurve(to: CGPoint(x: 68.87, y: 87.82), controlPoint1: CGPoint(x: 69.71, y: 87.96), controlPoint2: CGPoint(x: 69.34, y: 87.82))
//        bezierPath.addCurve(to: CGPoint(x: 67.72, y: 88.29), controlPoint1: CGPoint(x: 68.4, y: 87.82), controlPoint2: CGPoint(x: 68.02, y: 87.98))
//        bezierPath.addCurve(to: CGPoint(x: 67.27, y: 89.48), controlPoint1: CGPoint(x: 67.42, y: 88.6), controlPoint2: CGPoint(x: 67.27, y: 89))
//        bezierPath.addLine(to: CGPoint(x: 67.27, y: 94))
//        bezierPath.addLine(to: CGPoint(x: 66.08, y: 94))
//        bezierPath.addLine(to: CGPoint(x: 66.08, y: 89.24))
//        bezierPath.addCurve(to: CGPoint(x: 65.68, y: 88.21), controlPoint1: CGPoint(x: 66.08, y: 88.81), controlPoint2: CGPoint(x: 65.95, y: 88.47))
//        bezierPath.addCurve(to: CGPoint(x: 64.62, y: 87.82), controlPoint1: CGPoint(x: 65.42, y: 87.95), controlPoint2: CGPoint(x: 65.06, y: 87.82))
//        bezierPath.addCurve(to: CGPoint(x: 63.45, y: 88.31), controlPoint1: CGPoint(x: 64.15, y: 87.82), controlPoint2: CGPoint(x: 63.76, y: 87.98))
//        bezierPath.addCurve(to: CGPoint(x: 63, y: 89.54), controlPoint1: CGPoint(x: 63.15, y: 88.64), controlPoint2: CGPoint(x: 63, y: 89.05))
//        bezierPath.addLine(to: CGPoint(x: 63, y: 94))
//        bezierPath.addLine(to: CGPoint(x: 61.81, y: 94))
//        bezierPath.close()
//        bezierPath.move(to: CGPoint(x: 76.51, y: 86.77))
//        bezierPath.addCurve(to: CGPoint(x: 78.71, y: 87.77), controlPoint1: CGPoint(x: 77.42, y: 86.77), controlPoint2: CGPoint(x: 78.15, y: 87.1))
//        bezierPath.addCurve(to: CGPoint(x: 79.55, y: 90.45), controlPoint1: CGPoint(x: 79.27, y: 88.44), controlPoint2: CGPoint(x: 79.55, y: 89.33))
//        bezierPath.addCurve(to: CGPoint(x: 78.72, y: 93.12), controlPoint1: CGPoint(x: 79.55, y: 91.55), controlPoint2: CGPoint(x: 79.27, y: 92.44))
//        bezierPath.addCurve(to: CGPoint(x: 76.54, y: 94.12), controlPoint1: CGPoint(x: 78.16, y: 93.79), controlPoint2: CGPoint(x: 77.43, y: 94.12))
//        bezierPath.addCurve(to: CGPoint(x: 75.19, y: 93.78), controlPoint1: CGPoint(x: 76.04, y: 94.12), controlPoint2: CGPoint(x: 75.59, y: 94.01))
//        bezierPath.addCurve(to: CGPoint(x: 74.27, y: 92.84), controlPoint1: CGPoint(x: 74.79, y: 93.55), controlPoint2: CGPoint(x: 74.49, y: 93.24))
//        bezierPath.addLine(to: CGPoint(x: 74.25, y: 92.84))
//        bezierPath.addLine(to: CGPoint(x: 74.25, y: 96.37))
//        bezierPath.addLine(to: CGPoint(x: 73.06, y: 96.37))
//        bezierPath.addLine(to: CGPoint(x: 73.06, y: 86.89))
//        bezierPath.addLine(to: CGPoint(x: 74.19, y: 86.89))
//        bezierPath.addLine(to: CGPoint(x: 74.19, y: 88.09))
//        bezierPath.addLine(to: CGPoint(x: 74.21, y: 88.09))
//        bezierPath.addCurve(to: CGPoint(x: 75.15, y: 87.12), controlPoint1: CGPoint(x: 74.44, y: 87.68), controlPoint2: CGPoint(x: 74.75, y: 87.36))
//        bezierPath.addCurve(to: CGPoint(x: 76.51, y: 86.77), controlPoint1: CGPoint(x: 75.55, y: 86.89), controlPoint2: CGPoint(x: 76, y: 86.77))
//        bezierPath.close()
//        bezierPath.move(to: CGPoint(x: 76.28, y: 93.08))
//        bezierPath.addCurve(to: CGPoint(x: 77.78, y: 92.37), controlPoint1: CGPoint(x: 76.91, y: 93.08), controlPoint2: CGPoint(x: 77.41, y: 92.84))
//        bezierPath.addCurve(to: CGPoint(x: 78.33, y: 90.45), controlPoint1: CGPoint(x: 78.15, y: 91.89), controlPoint2: CGPoint(x: 78.33, y: 91.25))
//        bezierPath.addCurve(to: CGPoint(x: 77.78, y: 88.52), controlPoint1: CGPoint(x: 78.33, y: 89.64), controlPoint2: CGPoint(x: 78.15, y: 89))
//        bezierPath.addCurve(to: CGPoint(x: 76.28, y: 87.81), controlPoint1: CGPoint(x: 77.41, y: 88.05), controlPoint2: CGPoint(x: 76.91, y: 87.81))
//        bezierPath.addCurve(to: CGPoint(x: 74.8, y: 88.54), controlPoint1: CGPoint(x: 75.67, y: 87.81), controlPoint2: CGPoint(x: 75.17, y: 88.06))
//        bezierPath.addCurve(to: CGPoint(x: 74.24, y: 90.45), controlPoint1: CGPoint(x: 74.43, y: 89.02), controlPoint2: CGPoint(x: 74.24, y: 89.66))
//        bezierPath.addCurve(to: CGPoint(x: 74.8, y: 92.36), controlPoint1: CGPoint(x: 74.24, y: 91.24), controlPoint2: CGPoint(x: 74.43, y: 91.88))
//        bezierPath.addCurve(to: CGPoint(x: 76.28, y: 93.08), controlPoint1: CGPoint(x: 75.17, y: 92.84), controlPoint2: CGPoint(x: 75.67, y: 93.08))
//        bezierPath.close()
//        bezierPath.move(to: CGPoint(x: 80.82, y: 94))
//        bezierPath.addLine(to: CGPoint(x: 80.82, y: 86.89))
//        bezierPath.addLine(to: CGPoint(x: 82.01, y: 86.89))
//        bezierPath.addLine(to: CGPoint(x: 82.01, y: 94))
//        bezierPath.addLine(to: CGPoint(x: 80.82, y: 94))
//        bezierPath.close()
//        bezierPath.move(to: CGPoint(x: 81.41, y: 85.69))
//        bezierPath.addCurve(to: CGPoint(x: 80.89, y: 85.48), controlPoint1: CGPoint(x: 81.21, y: 85.69), controlPoint2: CGPoint(x: 81.04, y: 85.62))
//        bezierPath.addCurve(to: CGPoint(x: 80.67, y: 84.96), controlPoint1: CGPoint(x: 80.75, y: 85.33), controlPoint2: CGPoint(x: 80.67, y: 85.16))
//        bezierPath.addCurve(to: CGPoint(x: 80.89, y: 84.44), controlPoint1: CGPoint(x: 80.67, y: 84.75), controlPoint2: CGPoint(x: 80.75, y: 84.58))
//        bezierPath.addCurve(to: CGPoint(x: 81.41, y: 84.22), controlPoint1: CGPoint(x: 81.04, y: 84.29), controlPoint2: CGPoint(x: 81.21, y: 84.22))
//        bezierPath.addCurve(to: CGPoint(x: 81.94, y: 84.44), controlPoint1: CGPoint(x: 81.62, y: 84.22), controlPoint2: CGPoint(x: 81.79, y: 84.29))
//        bezierPath.addCurve(to: CGPoint(x: 82.16, y: 84.96), controlPoint1: CGPoint(x: 82.08, y: 84.58), controlPoint2: CGPoint(x: 82.16, y: 84.75))
//        bezierPath.addCurve(to: CGPoint(x: 81.94, y: 85.48), controlPoint1: CGPoint(x: 82.16, y: 85.16), controlPoint2: CGPoint(x: 82.08, y: 85.33))
//        bezierPath.addCurve(to: CGPoint(x: 81.41, y: 85.69), controlPoint1: CGPoint(x: 81.79, y: 85.62), controlPoint2: CGPoint(x: 81.62, y: 85.69))
//        bezierPath.close()
//        bezierPath.move(to: CGPoint(x: 85.96, y: 93.11))
//        bezierPath.addCurve(to: CGPoint(x: 87.37, y: 92.59), controlPoint1: CGPoint(x: 86.52, y: 93.11), controlPoint2: CGPoint(x: 86.99, y: 92.94))
//        bezierPath.addCurve(to: CGPoint(x: 87.94, y: 91.3), controlPoint1: CGPoint(x: 87.75, y: 92.24), controlPoint2: CGPoint(x: 87.94, y: 91.81))
//        bezierPath.addLine(to: CGPoint(x: 87.94, y: 90.72))
//        bezierPath.addLine(to: CGPoint(x: 86.04, y: 90.83))
//        bezierPath.addCurve(to: CGPoint(x: 84.92, y: 91.18), controlPoint1: CGPoint(x: 85.56, y: 90.87), controlPoint2: CGPoint(x: 85.19, y: 90.98))
//        bezierPath.addCurve(to: CGPoint(x: 84.54, y: 91.99), controlPoint1: CGPoint(x: 84.67, y: 91.38), controlPoint2: CGPoint(x: 84.54, y: 91.65))
//        bezierPath.addCurve(to: CGPoint(x: 84.92, y: 92.8), controlPoint1: CGPoint(x: 84.54, y: 92.33), controlPoint2: CGPoint(x: 84.67, y: 92.6))
//        bezierPath.addCurve(to: CGPoint(x: 85.96, y: 93.11), controlPoint1: CGPoint(x: 85.18, y: 93.01), controlPoint2: CGPoint(x: 85.53, y: 93.11))
//        bezierPath.close()
//        bezierPath.move(to: CGPoint(x: 85.69, y: 94.12))
//        bezierPath.addCurve(to: CGPoint(x: 83.97, y: 93.54), controlPoint1: CGPoint(x: 84.98, y: 94.12), controlPoint2: CGPoint(x: 84.41, y: 93.93))
//        bezierPath.addCurve(to: CGPoint(x: 83.33, y: 91.99), controlPoint1: CGPoint(x: 83.54, y: 93.14), controlPoint2: CGPoint(x: 83.33, y: 92.63))
//        bezierPath.addCurve(to: CGPoint(x: 84, y: 90.53), controlPoint1: CGPoint(x: 83.33, y: 91.38), controlPoint2: CGPoint(x: 83.55, y: 90.89))
//        bezierPath.addCurve(to: CGPoint(x: 85.9, y: 89.91), controlPoint1: CGPoint(x: 84.45, y: 90.16), controlPoint2: CGPoint(x: 85.08, y: 89.96))
//        bezierPath.addLine(to: CGPoint(x: 87.94, y: 89.8))
//        bezierPath.addLine(to: CGPoint(x: 87.94, y: 89.2))
//        bezierPath.addCurve(to: CGPoint(x: 87.53, y: 88.18), controlPoint1: CGPoint(x: 87.94, y: 88.77), controlPoint2: CGPoint(x: 87.8, y: 88.43))
//        bezierPath.addCurve(to: CGPoint(x: 86.38, y: 87.81), controlPoint1: CGPoint(x: 87.26, y: 87.94), controlPoint2: CGPoint(x: 86.87, y: 87.81))
//        bezierPath.addCurve(to: CGPoint(x: 85.28, y: 88.11), controlPoint1: CGPoint(x: 85.93, y: 87.81), controlPoint2: CGPoint(x: 85.56, y: 87.91))
//        bezierPath.addCurve(to: CGPoint(x: 84.74, y: 88.94), controlPoint1: CGPoint(x: 85, y: 88.31), controlPoint2: CGPoint(x: 84.82, y: 88.59))
//        bezierPath.addLine(to: CGPoint(x: 83.59, y: 88.94))
//        bezierPath.addCurve(to: CGPoint(x: 84.41, y: 87.38), controlPoint1: CGPoint(x: 83.63, y: 88.31), controlPoint2: CGPoint(x: 83.91, y: 87.79))
//        bezierPath.addCurve(to: CGPoint(x: 86.41, y: 86.77), controlPoint1: CGPoint(x: 84.92, y: 86.97), controlPoint2: CGPoint(x: 85.59, y: 86.77))
//        bezierPath.addCurve(to: CGPoint(x: 88.39, y: 87.4), controlPoint1: CGPoint(x: 87.24, y: 86.77), controlPoint2: CGPoint(x: 87.9, y: 86.98))
//        bezierPath.addCurve(to: CGPoint(x: 89.13, y: 89.08), controlPoint1: CGPoint(x: 88.88, y: 87.82), controlPoint2: CGPoint(x: 89.13, y: 88.38))
//        bezierPath.addLine(to: CGPoint(x: 89.13, y: 94))
//        bezierPath.addLine(to: CGPoint(x: 88, y: 94))
//        bezierPath.addLine(to: CGPoint(x: 88, y: 92.78))
//        bezierPath.addLine(to: CGPoint(x: 87.97, y: 92.78))
//        bezierPath.addCurve(to: CGPoint(x: 87.03, y: 93.75), controlPoint1: CGPoint(x: 87.76, y: 93.18), controlPoint2: CGPoint(x: 87.44, y: 93.51))
//        bezierPath.addCurve(to: CGPoint(x: 85.69, y: 94.12), controlPoint1: CGPoint(x: 86.62, y: 94), controlPoint2: CGPoint(x: 86.17, y: 94.12))
//        bezierPath.close()
//        bezierPath.move(to: CGPoint(x: 90.64, y: 94))
//        bezierPath.addLine(to: CGPoint(x: 90.64, y: 86.89))
//        bezierPath.addLine(to: CGPoint(x: 91.76, y: 86.89))
//        bezierPath.addLine(to: CGPoint(x: 91.76, y: 88.03))
//        bezierPath.addLine(to: CGPoint(x: 91.79, y: 88.03))
//        bezierPath.addCurve(to: CGPoint(x: 92.67, y: 87.1), controlPoint1: CGPoint(x: 91.99, y: 87.63), controlPoint2: CGPoint(x: 92.29, y: 87.32))
//        bezierPath.addCurve(to: CGPoint(x: 94.04, y: 86.77), controlPoint1: CGPoint(x: 93.05, y: 86.88), controlPoint2: CGPoint(x: 93.51, y: 86.77))
//        bezierPath.addCurve(to: CGPoint(x: 95.86, y: 87.47), controlPoint1: CGPoint(x: 94.82, y: 86.77), controlPoint2: CGPoint(x: 95.42, y: 87))
//        bezierPath.addCurve(to: CGPoint(x: 96.5, y: 89.39), controlPoint1: CGPoint(x: 96.29, y: 87.94), controlPoint2: CGPoint(x: 96.5, y: 88.57))
//        bezierPath.addLine(to: CGPoint(x: 96.5, y: 94))
//        bezierPath.addLine(to: CGPoint(x: 95.32, y: 94))
//        bezierPath.addLine(to: CGPoint(x: 95.32, y: 89.6))
//        bezierPath.addCurve(to: CGPoint(x: 94.91, y: 88.28), controlPoint1: CGPoint(x: 95.32, y: 89.02), controlPoint2: CGPoint(x: 95.18, y: 88.58))
//        bezierPath.addCurve(to: CGPoint(x: 93.68, y: 87.82), controlPoint1: CGPoint(x: 94.63, y: 87.97), controlPoint2: CGPoint(x: 94.22, y: 87.82))
//        bezierPath.addCurve(to: CGPoint(x: 92.33, y: 88.37), controlPoint1: CGPoint(x: 93.12, y: 87.82), controlPoint2: CGPoint(x: 92.67, y: 88))
//        bezierPath.addCurve(to: CGPoint(x: 91.83, y: 89.82), controlPoint1: CGPoint(x: 92, y: 88.73), controlPoint2: CGPoint(x: 91.83, y: 89.21))
//        bezierPath.addLine(to: CGPoint(x: 91.83, y: 94))
//        bezierPath.addLine(to: CGPoint(x: 90.64, y: 94))
//        bezierPath.close()
//
//        return bezierPath
//    }
//
//}
