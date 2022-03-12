//
//  Constraints.swift
//  Health Tracker
//
//  Created by Abhishek Dhiman on 27/07/21.
//  Copyright © 2021 Abhishek Dhiman. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
  func anchor(top:NSLayoutYAxisAnchor?,leading:NSLayoutXAxisAnchor?,bottom:NSLayoutYAxisAnchor?,trailing:NSLayoutXAxisAnchor?,padding:UIEdgeInsets = .zero,size:CGSize = .zero) -> [NSLayoutConstraint]{

    translatesAutoresizingMaskIntoConstraints = false
    var anchors = [NSLayoutConstraint]()
    

    if let top = top{
        anchors.append(topAnchor.constraint(equalTo: top,constant: padding.top))
    }

    if let leading = leading{
        anchors.append(leadingAnchor.constraint(equalTo: leading,constant: padding.left))
    }

    if let trailing = trailing{
        anchors.append(trailingAnchor.constraint(equalTo: trailing,constant: -padding.right))
    }

    if let bottom = bottom{
        anchors.append(bottomAnchor.constraint(equalTo: bottom,constant: -padding.bottom))
    }


    if size.width != 0{
        anchors.append(widthAnchor.constraint(equalToConstant: size.width))
    }

    if size.height != 0{
        anchors.append(heightAnchor.constraint(equalToConstant: size.height))
    }
    anchors.forEach({$0.isActive = true})
   
    return anchors

  }
    func centerX(inView view : UIView, offset: CGSize = .zero) {
      centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: offset.width).isActive = true
    }
    
    func centerY(inView view : UIView, offset: CGSize = .zero) {
      centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: offset.height).isActive = true
    }
    
    func centerXY(inView view : UIView, offset: CGSize = .zero) {
      centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: offset.width).isActive = true
      centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: offset.height).isActive = true
    }
    
    func heightEqualToView(_ view : UIView, multiplier: CGFloat) {
      heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier).isActive = true
    }
    
    func widthEqualToView(_ view : UIView, multiplier: CGFloat) {
      widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier).isActive = true
    }
}

extension UIColor {

convenience init(r:CGFloat,g:CGFloat,b:CGFloat) {

  self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
}
}

extension NSAttributedString {

   static func makeHyperLink(path:String,string: String,substring:String) -> NSAttributedString {
    let nsString = NSString(string: string)
    let subStringRange = nsString.range(of: substring)
    let attributedString = NSMutableAttributedString(string: string)
    attributedString.addAttribute(.link, value:path, range: subStringRange)
    return attributedString
  }

}

extension UIView {
  func roundCorners(_ corners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: CGFloat) {
    if #available(iOS 11, *) {
      self.layer.cornerRadius = radius
      self.layer.maskedCorners = corners
    } else {
      var cornerMask = UIRectCorner()
      if(corners.contains(.layerMinXMinYCorner)){
        cornerMask.insert(.topLeft)
      }
      if(corners.contains(.layerMaxXMinYCorner)){
        cornerMask.insert(.topRight)
      }
      if(corners.contains(.layerMinXMaxYCorner)){
        cornerMask.insert(.bottomLeft)
      }
      if(corners.contains(.layerMaxXMaxYCorner)){
        cornerMask.insert(.bottomRight)
      }
      let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: cornerMask, cornerRadii: CGSize(width: radius, height: radius))
      let mask = CAShapeLayer()
      mask.path = path.cgPath
      self.layer.mask = mask
    }
  }
}
