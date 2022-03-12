//
//  FutureHeaderView.swift
//  HealthTracker
//
//  Created by Apple on 22/11/21.
//

import Foundation

import UIKit

class FutureHeaderView : ExtendedView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        intialization()
        backgroundColor = .white
    }
    
    func intialization(){
        setupViews()
        layoutUI()
    }
    
    
    //MARK: - Setup Views
    
    lazy var headerLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "Test Abhishek 01"
        lbl.textAlignment = .center
        lbl.font = UIFont(name: AppThemeConfig.boldFont, size: 19)
        lbl.textColor = .white
        return lbl
    }()
    
    lazy var containerView : UIView = {
        let view = UIView()
        view.backgroundColor = AppThemeConfig.DarkGreen
        view.rounded(cornerRadius: 6)
        return view
    }()
    
    lazy var headerImg : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "calendar")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        img.contentMode = .scaleToFill
        return img
    }()
    
    lazy var itemsStack : UIStackView = {
        let sv = UIStackView(arrangedSubviews: [headerImg,headerLbl])
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.spacing = 5
        return sv
    }()
    
    func setupViews(){
        self.addSubview(containerView)
        self.containerView.addSubview(itemsStack)
    }
    
    func layoutUI(){
       _ = containerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 2, left: 2, bottom: 2, right: 2))
        
        _ = headerImg.anchor(top: nil, leading: nil, bottom: nil, trailing: nil,size: .init(width: 30, height: 30))
        
        _ = itemsStack.anchor(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: nil,padding: .init(top: 5, left: 30, bottom: 5, right: 30))
        itemsStack.centerX(inView: containerView)
    }
    
}
