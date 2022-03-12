//
//  MenuBarCell.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 12/08/21.
//

import Foundation
import UIKit

class MenuBarCell : ExtendedCollectionCell {
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        backgroundColor = .systemPink
        setupView()
        layoutUI()
    }
    
    
    //MARK:- Properties
    
    lazy var optionNameLbl : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.text = "Today's"
        lbl.backgroundColor = AppThemeConfig.DarkGreen
        lbl.font = UIFont(name: AppThemeConfig.boldFont, size: 16)
        return lbl
    }()
    
    //MARK:- Handle selection
    
    override var isHighlighted: Bool{
        didSet{
            
        }
    }
    
    override var isSelected: Bool{
        didSet{
            
        }
    }
    
    //MARK:- Setup View

    func setupView(){
        addSubview(optionNameLbl)
    }
    
    //MARK:- Layout UI
    
    func layoutUI(){
        _ = optionNameLbl.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
    }
    
    
}
