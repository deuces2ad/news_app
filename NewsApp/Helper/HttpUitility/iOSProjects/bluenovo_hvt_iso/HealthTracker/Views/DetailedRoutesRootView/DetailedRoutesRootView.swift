//
//  DetailedRoutesRootView.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 26/08/21.
//

import Foundation
import UIKit
import GoogleMaps

class DetailedRoutesRootView: ExtendedView {
    
    var controller : DetailedRoutesController?
    var didListenAvoidTolls : ((Bool)->Void)?
    
    //MARK:- LifeCycle
    override func viewDidLayout() {
        super.viewDidLayout()
        backgroundColor = .white
        initialization()
    }
    
     //MARK:-Initialization
    func initialization(){
        addViews()
        layoutUI()
        tollSwithch.isOn = false
        tollSwithch.setupUI()
    }
    
    //MARK:- Properties
    
    lazy var mapView : GMSMapView = {
        let map = GMSMapView()
        return map
    }()
    
    lazy var customMarker : CustomMarkerView = {
        let marker = CustomMarkerView(frame: .init(x: 0, y: 0, width: 60, height: 60), imageName:#imageLiteral(resourceName: "ic_profile"), borderColor: .black, isWithDownArrow: true, isTagLblRequired: true)
        marker.layer.cornerRadius = 30
        marker.clipsToBounds = true
        return marker
    }()
    
    lazy var doctorMarker : CustomMarkerView = {
        let marker = CustomMarkerView(frame: .init(x: 0, y: 0, width: 60, height: 60), imageName:#imageLiteral(resourceName: "ic_slider_kit"), borderColor: .black, isWithDownArrow: true, isTagLblRequired: false)
       
        return marker
    }()
    
    lazy var tollSwithch : CustomSwitch = {
        let sw = CustomSwitch()
        sw.onTintColor = AppThemeConfig.DarkGreen
        return sw
    }()
    
    lazy var avoidTollsLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: AppThemeConfig.boldFont, size: 14)
        lbl.textAlignment = .center
        lbl.text = " Avoid Tolls ".localized()
        lbl.textColor = .white
        lbl.backgroundColor = AppThemeConfig.DarkGreen
        lbl.layer.cornerRadius = 4
        return lbl
    }()

    
    lazy var stackView : UIStackView = {
        let sv = UIStackView(arrangedSubviews: [mapView,appointmentsTblView])
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        sv.backgroundColor = .red
        return sv
    }()
    
    
    lazy var appointmentsTblView : UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        return view
    }()
    
    //MARK:- SetupView
    
    func addViews(){
        addSubview(stackView)
        mapView.addSubview(tollSwithch)
        mapView.addSubview(avoidTollsLbl)
       
        
        tollSwithch.isOn {[weak self] value in
            guard let weaksellf = self else {return}
            Log.echo(key: "abhi", text: "\(value)")
            weaksellf.didListenAvoidTolls?(value)
        }
        
    }
    
    //MARK:- Action or Objc functions
   
    
    //MARK:- Layout UI
    func layoutUI(){
        
        _ = tollSwithch.anchor(top: safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 10),size: .init(width: 48, height: 14))

        _ = avoidTollsLbl.anchor(top: nil, leading: nil, bottom: nil, trailing: tollSwithch.leadingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 10))
        avoidTollsLbl.centerY(inView: tollSwithch)
        
        
        _ = stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
    }

}
