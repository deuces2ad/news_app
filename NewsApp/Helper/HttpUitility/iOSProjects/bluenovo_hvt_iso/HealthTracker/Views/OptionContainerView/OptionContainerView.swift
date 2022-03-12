//
//  OptionContainerView.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 01/09/21.
//

import Foundation
import UIKit

class OptionContainerView: ExtendedView {
    
//    weak var delagate : DeatailedTrackInfoDelegate?
    var title : String?
    var countryName : String?
    
    override func viewDidLayout() {
        super.viewDidLayout()
        setupViews()
        layoutUI()
    }
    
    init(title : String, countryName : String) {
        super.init(frame: .zero)
        self.title = title
        self.countryName = countryName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var containerView : UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var headerlbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: AppThemeConfig.defaultFont, size: 18)
        lbl.textColor = .black
        lbl.backgroundColor = .clear
        lbl.text = self.title
        lbl.textAlignment = .center
        return lbl
    }()
    
    lazy var buttn : UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    lazy var slectedImg : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    lazy var countryFlagImg : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: self.countryName ?? "")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    
    //MARK:- SetupView
    func setupViews(){
        addSubview(containerView)
        containerView.addSubview(headerlbl)
        containerView.addSubview(countryFlagImg)
        countryFlagImg.addSubview(slectedImg)
        containerView.addSubview(buttn)
    }
    
    //MARK:- Layout UI
    
    func layoutUI(){
        
        _ = containerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        
        _ = countryFlagImg.anchor(top: topAnchor, leading: leadingAnchor, bottom: headerlbl.topAnchor, trailing: trailingAnchor,padding: .init(top: 30, left: 40, bottom: 20, right: 40))
        
        _ = headerlbl.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: nil)
        headerlbl.centerX(inView: countryFlagImg)
        
        _ = slectedImg.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 5, left: 0, bottom: 0, right: 5),size: .init(width: 20, height: 20))
        
        _ = buttn.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
    }
    
    func selected(){
        containerView.backgroundColor = AppThemeConfig.LightGreen.withAlphaComponent(0.35)
        slectedImg.image = UIImage(named: "ic_checked")
    }
    
    func deSelected(){
        containerView.backgroundColor = .white
        slectedImg.image = UIImage().withTintColor(.clear)
    }
    
    
}
