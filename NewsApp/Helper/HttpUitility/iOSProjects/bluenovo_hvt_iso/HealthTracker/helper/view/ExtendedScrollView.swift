//
//  ExtendedScrollView.swift
//  BN PERKS
//
//  Created by Sumant Handa on 09/06/17.
//  Copyright © 2017 Mansa. All rights reserved.
//

import UIKit

class ExtendedScrollView: UIScrollView {
    
    private var isLoaded = false;

    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if(!isLoaded){
            isLoaded = true
            viewDidLayout()
        }
    }
    
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        Log.echo(key: "", text: "didMoveToSuperview")
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        
        Log.echo(key: "", text: "removeFromSuperview")
    }
    
    func viewDidLayout(){
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never
        }
    }


}

 extension UIView {

  func viewBorder(borderColor : UIColor, borderWidth : CGFloat?) {
    self.layer.borderColor = borderColor.cgColor
    if let borderWidth_ = borderWidth {
      self.layer.borderWidth = borderWidth_
    } else {
      self.layer.borderWidth = 1.0
    }
  }
  
  var parentViewController: UIViewController? {
    var parentResponder: UIResponder? = self
    while parentResponder != nil {
      if let firstResponder = parentResponder?.next {
        parentResponder = firstResponder
        if let viewController = parentResponder as? UIViewController {
          return viewController
        }
      }
    }
    return nil
  }
}

import UIKit

extension UIView {
  func applyShadow(
    apply: Bool,
    color: UIColor = UIColor.black,
    offset: CGSize = CGSize(width: 0.0, height: 2.0),
    opacity: Float = 0.2, radius: Float = 1.0,
    shadowRect: CGRect? = nil) {
    self.layer.shadowColor = apply ? color.cgColor : UIColor.white.withAlphaComponent(0.0).cgColor
    self.layer.shadowOffset = apply ? offset : CGSize(width: 0.0, height: 0.0)
    self.layer.shadowOpacity = apply ? opacity : 0.0
    self.layer.shadowRadius = apply ? CGFloat(radius) : 0.0
    self.layer.masksToBounds = false
    if let shadowRect = shadowRect {
      self.layer.shadowPath = UIBezierPath(rect: shadowRect).cgPath
    }
  }
  
  func roundedUsingHeight() {
    self.rounded(cornerRadius: self.frame.size.height/2)
  }
  
  func rounded(cornerRadius: CGFloat) {
    self.layer.cornerRadius = cornerRadius
    self.layer.masksToBounds = true
  }
}
