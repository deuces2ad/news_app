//
//  DetailAppointmentCell.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 16/08/21.
//

import Foundation
import UIKit

class DetailAppointmentCell: ExtendedTableCell {
    
    //MARK:-Life Cycle
    override func viewDidLayout() {
        super.viewDidLayout()
        
        setupViews()
        layoutUI()
    }
    //MARK:-Properties
    lazy var containerView : UIView = {
        let uv = UIView()
        uv.backgroundColor = .red
        uv.layer.cornerRadius = 12
        uv.applyShadow(apply: true, color: UIColor(hexString: "#3E4958"), offset: .init(width: -3, height: 4), opacity: 0.4, radius: 3, shadowRect: nil)
        return uv
    }()
    
    lazy var profileImg : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "ic_defaultplaceholder")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var userName : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: AppThemeConfig.boldFont, size: 16)
        lbl.textColor = UIColor(hexString: "#003366")
        lbl.numberOfLines = 0
        return lbl
    }()
    
    //MARK:-Setup Views
    
    func setupViews(){
        addSubview(containerView)
        containerView.addSubview(profileImg)
    }
    
    //MARK:-Layout UI

    func layoutUI(){
        
        _ = containerView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: bottomAnchor, trailing: contentView.trailingAnchor,padding: .init(top: 10, left: 10, bottom:10, right: 10))
        
        _ = profileImg.anchor(top: nil, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: nil,padding: .init(top: 10, left: 10, bottom: 0, right: 0),size: .init(width: 50, height: 50))
        profileImg.centerY(inView: containerView)
        
    }
}
