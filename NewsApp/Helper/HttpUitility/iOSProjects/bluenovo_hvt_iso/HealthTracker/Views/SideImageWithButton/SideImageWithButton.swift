//
//  SideImageWithButton.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 20/09/21.
//

import Foundation

import UIKit

class SideImageWithButton: ExtendedView {
    
    override func viewDidLayout() {
        super.viewDidLayout()
        setupView()
        layoutUI()
    }
    
    var image : UIImage?
    var title : String?
    var isDisabled = false
    
    
    init(with image :UIImage, title : String) {
        super.init(frame: .zero)
        self.image = image
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var btn :UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = UIFont(name: AppThemeConfig.defaultFont, size: 18)
        btn.tintColor = .white
        return btn
    }()
    
    lazy var img : UIImageView = {
        let img = UIImageView()
        img.image = image
        img.image?.withTintColor(.red)
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    
    func setupView(){
        addSubview(btn)
        addSubview(img)
    }
    
    func layoutUI(){
      
        _ = btn.anchor(top: nil, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        btn.centerXY(inView: self)
        
        _ =  img.anchor(top: nil, leading: btn.trailingAnchor, bottom: nil, trailing: nil,padding: .init(top: 0, left: 5, bottom: 0, right: 10),size: .init(width: 20, height: 20))
        img.centerY(inView: btn)
    }
    
}
