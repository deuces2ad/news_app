//
//  FetchAdressRootView.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 03/08/21.
//


protocol FetchAdressControllerDelegate : class {
    func didReceiveLocation(with address : String)
}

import Foundation
import UIKit
import GoogleMaps



class FetchAdressRootView: ExtendedView {
  
    
    let TAG = "FetchAdressRootView"
    
    var controller : FetchAddressController?
    var fetchAdressControllerDelegate : FetchAdressControllerDelegate?
    
    //MARK:- LifeCycle
    override func viewDidLayout() {
        super.viewDidLayout()
        
        paintInterface()
    }
    
    fileprivate func paintInterface(){
        setupViews()
        layoutUI()
    }
    
    //MARK:- Properties
    
    lazy var mapView : GMSMapView = {
        let mapView = GMSMapView()
        return mapView
    }()
    
    lazy var serchtxtFld : PersonalInfoTextFieldView = {
        let txtFld = PersonalInfoTextFieldView(header: "", placeHolder: "Search Location", isRequired: false, image: UIImage(systemName: "magnifyingglass")!, textFiledDelegate: controller!)
        txtFld.backgroundColor = .white
        return txtFld
    }()
    
    lazy var pinImg : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "user_current_location_pin").withTintColor(AppThemeConfig.DarkGreen, renderingMode: .alwaysOriginal)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var dragTheMapLbl : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.text = " DRAG THE MAP "
        lbl.backgroundColor = AppThemeConfig.DarkGreen
        lbl.font = UIFont(name: AppThemeConfig.boldFont, size: 10)
        return lbl
    }()
    
    
    lazy var currentLocationBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "current-location")?.withTintColor(AppThemeConfig.DarkGreen, renderingMode: .alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(didtapCurrentLocation), for: .touchUpInside)
        return btn
    }()
    
    
    lazy var confirmLocationBtn : UserLocationMarkerInfoWindow = {
        let view = UserLocationMarkerInfoWindow(delegate: self)
        return view
    }()
    
    fileprivate func setupViews(){
        addSubview(mapView)
        addSubview(pinImg)
        addSubview(serchtxtFld)
        addSubview(dragTheMapLbl)
        addSubview(currentLocationBtn)
        addSubview(confirmLocationBtn)
        
    
    }
    
    @objc func didtapCurrentLocation(){
        controller?.animateCameraToCurrentLocation()
        self.dragTheMapLbl.isHidden = false
    }
    
    @objc func confirmLocationAction(){
        
    }
    
    fileprivate func layoutUI(){
        _ = mapView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        _ = serchtxtFld.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 20, left: 20, bottom: 0, right: 20))
        _ = pinImg.anchor(top: nil, leading: nil, bottom: nil, trailing: nil,size: .init(width: 50, height: 50))
        pinImg.centerXY(inView: mapView)
        
        _ = dragTheMapLbl.anchor(top: pinImg.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 10, left: 0, bottom: 0, right: 0),size: .init(width: 90, height: 30))
        
        dragTheMapLbl.centerX(inView: pinImg)
        
        _ = currentLocationBtn.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 20, right: 20),size: .init(width: 40, height: 40))
        
        _ = confirmLocationBtn.anchor(top: nil, leading: nil, bottom: pinImg.topAnchor, trailing: nil,padding: .init(top: 0, left: 0, bottom: 10, right: 0),size: .init(width: 220, height: 70))
        confirmLocationBtn.centerX(inView: pinImg)
    }
}

extension FetchAdressRootView: UserLocationMarkerInfoWindowDelegate {
    func didTapConfirmPickupLocation() {
        fetchAdressControllerDelegate!.didReceiveLocation(with: serchtxtFld.infoTxtField.text ?? "Error")
        self.controller?.navigationController?.popViewController(animated: true)
    }
}
