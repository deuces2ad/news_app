//
//  EmptyWindowView.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 29/11/21.
//

import Foundation
import UIKit

class EmptyWindowView : ExtendedView {
    
    var requiredImg : UIImage?
    var text : String?
    
    override func viewDidLayout() {
        super.viewDidLayout()
        setUpViews()
        layoutUI()
    }
   
    init(with image :UIImage, title : String) {
        super.init(frame: .null)
        self.requiredImg = image
        self.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var image : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "calendar")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    lazy var infotext : UILabel = {
        let lbl = UILabel()
        lbl.text = text
        lbl.numberOfLines = 2
        lbl.font = UIFont(name: AppThemeConfig.boldFont, size: 14)
        lbl.textColor = .lightGray
        lbl.textAlignment = .center
        return lbl
    }()
    
    func setUpViews(){
        addSubview(image)
        addSubview(infotext)
    }
    
    func layoutUI(){
        _ = image.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 0, left: 0, bottom: 0, right: 0),size: .init(width: 50, height: 50))
        image.centerX(inView: self)
        
        _ = infotext.anchor(top: image.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 5, left: 0, bottom: 0, right: 0))

    }
}
