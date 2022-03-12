//
//  CustomMarkerWindow.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 09/08/21.
//


protocol CustomMarkerWindowDelegate : class {
    func didTapOnMarkerWindow()
}

import Foundation
import UIKit
import GoogleMaps
import CoreLocation

class CustomMarkerView: UIView {
    
    var imageName: UIImage?
    var borderColor: UIColor!
    var index : Int?
    var isWithDownArrow : Bool?
    var isTagLblRequired : Bool?
    
    init(frame: CGRect, imageName: UIImage?, borderColor: UIColor, isWithDownArrow : Bool, isTagLblRequired : Bool) {
        super.init(frame: frame)
        self.imageName = imageName
        self.borderColor = borderColor
        self.isWithDownArrow = isWithDownArrow
        self.isTagLblRequired  = isTagLblRequired
        
        self.tag = tag
        setupView()
        layoutUI()
    }
    
    lazy var tagLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "A"
        lbl.backgroundColor = AppThemeConfig.LightGreen
        lbl.textColor = AppThemeConfig.DarkGreen
        lbl.textAlignment = .center
        lbl.font = UIFont(name: AppThemeConfig.boldFont, size: 26)
        lbl.layer.cornerRadius = 25
        lbl.layer.masksToBounds = true
        return lbl
    }()
    
    
    lazy var imgView : UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 26
        img.contentMode = .scaleAspectFill
        img.image = imageName
        img.layer.masksToBounds = true
        return img
    }()
    
    lazy var triangleImgView : UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "ic_waypoint").withTintColor(AppThemeConfig.DarkGreen, renderingMode: .alwaysOriginal)
        img.image?.withTintColor(AppThemeConfig.DarkGreen, renderingMode: .alwaysOriginal)
        img.isHidden = false
        return img
    }()

    func layoutUI(){
        _ = imgView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: nil,size: .init(width: 50, height: 50))
        imgView.centerX(inView: self)
        
        if  isTagLblRequired  ?? false{
            _ = tagLbl.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: nil,size: .init(width: 50, height: 50))
            tagLbl.centerX(inView: self)
        }
       
        
        if (isWithDownArrow ?? false){
            _ = triangleImgView.anchor(top: imgView.bottomAnchor, leading: nil, bottom: bottomAnchor, trailing: nil,padding: .init(top: -8, left: 0, bottom: 0, right: 0),size: .init(width: 15, height: 15))
            triangleImgView.centerX(inView: imgView)
        }
    }

    func setupView(){
        
        if (isWithDownArrow ?? false){
            addSubview(triangleImgView)
        }
        if  isTagLblRequired  ?? false{
            addSubview(tagLbl)
            imgView.isHidden = true
        }
        addSubview(imgView)
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
