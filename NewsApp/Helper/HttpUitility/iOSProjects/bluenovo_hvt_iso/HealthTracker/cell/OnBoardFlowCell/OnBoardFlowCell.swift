//
//  OnBoardFlowCell.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 28/07/21.
//

import Foundation

import UIKit

class OnBoardFlowCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
      
        setupViews()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func paintInterface(){
        backgroundColor = .white
    }
    //MARK:- Properties
   
    
    lazy var backGrndImg : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor(hexString: AppThemeConfig.idealGray)
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .white
        return iv
    }()
    
    lazy var dispcriptionInfoLbl : UILabel =  {
        let tv = UILabel()
        tv.text = "SOME DUMMY TEXT HERE"
        tv.numberOfLines = 0
        tv.textAlignment = .center
        tv.textColor = .lightGray
        tv.font = UIFont(name: AppThemeConfig.defaultFont, size: 18)
        return tv
    }()
    
    
    lazy var titleLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "Dummy Text"
        lbl.font = UIFont(name: AppThemeConfig.boldFont, size: 18)
        lbl.textColor = AppThemeConfig.DarkGreen
        lbl.numberOfLines = 0
        return lbl
    }()
    
    lazy var containerView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    func fillInfo(with pageInfo: OnBoardFlowModal?){
        guard let info = pageInfo else{
            return
        }
        self.backGrndImg.image = nil
        self.backGrndImg.image = UIImage(named: info.backgroundImg)
        self.titleLbl.text = info.title
        self.dispcriptionInfoLbl.text = info.message
    
    }
    
    
    fileprivate func setupViews(){
        addSubview(backGrndImg)
        addSubview(containerView)
        containerView.addSubview(titleLbl)
        containerView.addSubview(dispcriptionInfoLbl)
        setupConstraints()
    }
    
    fileprivate func setupConstraints(){
        
        _ = backGrndImg.anchor(top: self.superview?.topAnchor, leading: self.leadingAnchor, bottom: self.containerView.topAnchor, trailing: self.trailingAnchor,padding: .init(top: 0, left: 10, bottom: 0, right: 10),size: .init(width: 300, height: 300))
        
        _ = containerView.anchor(top: nil, leading: self.backGrndImg.leadingAnchor, bottom: self.bottomAnchor, trailing: self.backGrndImg.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 15, right: 0))
        containerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        
       _ =  titleLbl.anchor(top: containerView.topAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 20, left: 0, bottom: 0, right: 0))
        titleLbl.centerX(inView: containerView)
        
       _ =  dispcriptionInfoLbl.anchor(top: titleLbl.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor,padding: .init(top: 10, left: 20, bottom: 20, right: 20))
        
    }
    
    
}
