//
//  SideImageLabel.swift
//  HealthTracker
//
//  Created by Apple on 08/10/21.
//

import Foundation
import UIKit

class SideImageLabel : ExtendedView {
    
    
    var img : UIImage?
    var titleInfo : String?
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        setupView()
        layoutUI()
    }
    
    init(title : String,image: UIImage) {
        super.init(frame: .zero)
        self.titleInfo = title
        self.img = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imageView : UIImageView = {
        let view = UIImageView()
        view.image = img
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var infoLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: AppThemeConfig.defaultFont, size: 16)
        lbl.textColor = AppThemeConfig.DarkGreen
        lbl.text = titleInfo
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    func setupView(){
        addSubview(imageView)
        addSubview(infoLbl)
    }
    
    func layoutUI(){
        _ = imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil,padding: .init(top: 0, left: 0, bottom: 0, right: 10),size: .init(width: 20, height: 20))
    
        _ = infoLbl.anchor(top: topAnchor, leading: imageView.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 5, bottom: 0, right: 0))
        
    }
}
