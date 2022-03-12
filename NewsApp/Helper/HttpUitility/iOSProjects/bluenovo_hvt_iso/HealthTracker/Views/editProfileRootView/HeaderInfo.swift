//
//  HeaderInfo.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 06/08/21.
//

import Foundation
import UIKit

class HeaderInfo: ExtendedView {
    
    
    lazy var headerLbl : UILabel = {
        let lbl = UILabel()
//        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        lbl.backgroundColor = .white
//        let edgeInsacts = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//        lbl.drawText(in: CGRect().inset(by: edgeInsacts))
        lbl.font = UIFont(name: AppThemeConfig.boldFont, size: 14)
        return lbl
    }()
    
    lazy var sepratorLine : UIView = {
        let uv = UIView()
        uv.backgroundColor = .gray
        return uv
    }()
    
    
    override func viewDidLayout() {
        super.viewDidLayout()
        self.addSubView()
        self.layoutUI()
    }
    
    
     init(header : String) {
        super.init(frame: .zero)
        self.headerLbl.text = header
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addSubView(){
        addSubview(sepratorLine)
        addSubview(headerLbl)
       
    }
    
    func layoutUI(){
        
        _ = headerLbl.anchor(top: nil, leading: nil, bottom: nil, trailing: nil,size: .init(width: 0, height: 20))
        headerLbl.centerXY(inView: self)
        
        _ = sepratorLine.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,size: .init(width: 0, height: 0.5))
        sepratorLine.centerXY(inView: headerLbl)
        
    }
}
