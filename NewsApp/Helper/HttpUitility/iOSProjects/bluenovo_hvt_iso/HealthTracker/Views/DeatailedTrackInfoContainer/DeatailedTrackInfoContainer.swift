//
//  DeatailedTrackInfoContainer.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 26/08/21.
//

import Foundation
import UIKit

class DeatailedTrackInfoContainer: ExtendedView {
    
    weak var delagate : DeatailedTrackInfoDelegate?
    
    override func viewDidLayout() {
        super.viewDidLayout()
        setupViews()
        layoutUI()
    }
    
    lazy var headerlbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: AppThemeConfig.defaultFont, size: 5)
        lbl.textColor = .lightGray
        lbl.text = "Tap below"
        lbl.textAlignment = .center
        lbl.backgroundColor = .red
        return lbl
    }()
    
    lazy var wayPointBtn : UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(didTapOnWaypoint), for: .touchUpInside)
        btn.backgroundColor = AppThemeConfig.LightGreen
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setImage(#imageLiteral(resourceName: "ic_mapview").withTintColor(AppThemeConfig.DarkGreen, renderingMode: .alwaysOriginal), for: .normal)
        return btn
    }()
    
    lazy var containerView : UIView = {
        let lbl = UIView()
        return lbl
    }()

 //MARK: - Actions or Objc functions
    @objc func didTapOnWaypoint(){
        Log.echo(key: "abhi", text: "didTapOnWaypoint")
        delagate?.showWayPoints()
        
    }
    
    //MARK:- SetupView
    func setupViews(){
        addSubview(containerView)
        containerView.addSubview(wayPointBtn)
        
    }
    
    //MARK:- Layout UI
    
    func layoutUI(){
        _ = containerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        _ = wayPointBtn.anchor(top: nil, leading: nil , bottom: nil, trailing: nil,size: .init(width: 30, height: 30))
        wayPointBtn.centerXY(inView: containerView)
        
    
    }
    
    
}
