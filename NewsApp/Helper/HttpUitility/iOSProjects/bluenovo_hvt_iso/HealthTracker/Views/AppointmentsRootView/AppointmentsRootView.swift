//
//  AppointmentsRootView.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 12/08/21.
//

import Foundation
import UIKit


class AppointmentsRootView: ExtendedView {
    
    let TAG = "AppointmentsRootView"
    
    let doctorOptions : [String] = ["Pending","All Appointments" ]
    let patientOptions : [String] = ["Pending".localized() ?? "","All Appointments".localized() ?? "" ]
    var menuOptions = [String]()
    
    var controller : ParentAppointmentController?
    var detailedTrackBottomAnchor : NSLayoutConstraint?
    
    override func viewDidLayout() {
        super.viewDidLayout()
        setMenues()
        setupViews()
        layoutUI()
    }
 
    func setMenues(){
        guard let role = SignedUserInfo.sharedInstance?.role else {
            return
        }
        
        if role == .doctor{
            menuOptions = doctorOptions
        }else{
            menuOptions = patientOptions
        }
    }
    
    //MARK:- Properties
    
    lazy var menuBar : UISegmentedControl = {
        let sc = UISegmentedControl(items: menuOptions)
        sc.selectedSegmentIndex = 0
        
        sc.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: AppThemeConfig.boldFont, size: 13)!,
                                   NSAttributedString.Key.foregroundColor: UIColor.blue
        ], for: .normal)
        
        sc.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: AppThemeConfig.boldFont, size: 16)!,
                                   NSAttributedString.Key.foregroundColor: UIColor.blue
        ], for: .selected)
        sc.addUnderlineForSelectedSegment()
        sc.backgroundColor = .yellow
        sc.heightAnchor.constraint(equalToConstant: 50).isActive = true
        sc.addTarget(self, action: #selector(didTapOnSegmentalController), for: .valueChanged)
        return sc
    }()
    
    lazy var tableView : UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.separatorStyle = .none
        return tv
    }()
    
    lazy var imageView : UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "ic_slider_logo")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    lazy var infoLbl : UILabel = {
        let lbl = UILabel()
        lbl.text =  SignedUserInfo.sharedInstance?.role == .doctor ? "Woohoo! No pending Appointements" : "You don't have any appointment yet!"
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    
    lazy var stackView : UIStackView = {
        let sv = UIStackView(arrangedSubviews: [menuBar,tableView])
        sv.axis = .vertical
        return sv
    }()
    
    lazy var horizonatalBar : UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    lazy var detailedTrackInfo : DeatailedTrackInfoContainer = {
        let v = DeatailedTrackInfoContainer()
        v.layer.cornerRadius = 30
        v.backgroundColor = AppThemeConfig.LightGreen
        v.clipsToBounds = true
        return v
    }()
    
    lazy var headerlbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: AppThemeConfig.boldFont, size: 12)
        lbl.textColor = .white
        lbl.text = " Today's Routes  "
        lbl.textAlignment = .center
        lbl.backgroundColor = AppThemeConfig.DarkGreen
        return lbl
    }()
    
    
    //MARK:- SetupView
    func setupViews(){
        addSubview(stackView)
        addSubview(imageView)
        addSubview(infoLbl)
        addSubview(detailedTrackInfo)
        addSubview(headerlbl)
    }
    
    //MARK:- Actions
    @objc func didTapOnSegmentalController(){
        Log.echo(key: "aa", text: "Tapped!!")
        controller?.handleSeletionOfTabs()
    }
    
    
    //MARK:- Layout UI
    func layoutUI(){
        _ = stackView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 10, right: 07))
        
        _ = imageView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,size: .init(width: 100, height: 100))
        imageView.centerXY(inView: self)
        imageView.bringSubviewToFront(stackView)
        
        _ = infoLbl.anchor(top: imageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        
        _ = menuBar.anchor(top: nil, leading: nil, bottom: nil, trailing: nil,padding: .zero,size: .init(width: 0, height: 50))
        
        detailedTrackBottomAnchor = detailedTrackInfo.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: UIDevice.current.userInterfaceIdiom == .pad ? 100 : 130, right: 30),size: .init(width: 60, height: 60))[1]
        
        _ = headerlbl.anchor(top: detailedTrackInfo.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        detailedTrackInfo.centerX(inView: headerlbl)
    }
    
    func showNoAppointmentMessage(){
        imageView.isHidden = false
        infoLbl.isHidden = false
    }
    
    func hideNoAppointmentMessage(){
        imageView.isHidden = true
        infoLbl.isHidden = true
    }
}

