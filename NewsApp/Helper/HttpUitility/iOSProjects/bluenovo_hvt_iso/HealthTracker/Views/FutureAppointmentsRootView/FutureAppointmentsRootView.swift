//
//  FutureAppointmentsRootView.swift
//  HealthTracker
//
//  Created by Apple on 19/11/21.
//

import Foundation
import UIKit

class FutureAppointmentsRootView : ExtendedView {
    
    let TAG = "FutureAppointmentsRootView"
    var controller : FutureAppointmentsController?
    var getDatesListener : (()->Void)?
    var getAppointmentListner : (()->())?

    //MARK: - LifeCycle
    override func viewDidLayout() {
        super.viewDidLayout()
        initilizeVariable()
    }
    
    func initilizeVariable(){
//        self.paintInterface()
        self.addViews()
        self.layoutUI()
        self.registerTapGesture()
    }
    
    func paintInterface(){
        self.backgroundColor = .white
    }
    
    //MARK: - TapGesture
    func registerTapGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(showCalendar))
        self.containerView.addGestureRecognizer(tap)
    }
    
    lazy var containerView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var tblView : UITableView = {
        let tblView = UITableView()
        tblView.separatorStyle = .none
        return tblView
    }()
    
    lazy var fromDateLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: AppThemeConfig.defaultFont, size: 14)
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.text = "Start Date"
        lbl.textAlignment = .center
        lbl.layer.borderColor = UIColor.lightGray.cgColor
        lbl.rounded(cornerRadius: 6)
        lbl.layer.borderWidth = 2
        return lbl
    }()
    
    lazy var toDateLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: AppThemeConfig.defaultFont, size: 14)
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.text = "End Date"
        lbl.textAlignment = .center
        lbl.layer.borderColor = UIColor.lightGray.cgColor
        lbl.layer.borderWidth = 2
        lbl.rounded(cornerRadius: 6)
        return lbl
    }()
    
    lazy var toLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: AppThemeConfig.boldFont, size: 14)
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.text = "To"
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    
    lazy var mainStackView : UIStackView = {
        let sv = UIStackView(arrangedSubviews: [containerView,tblView])
        sv.axis = .vertical
        return sv
    }()
    
    lazy var dateStackView : UIStackView = {
        let sv = UIStackView(arrangedSubviews: [fromDateLbl,toLbl,toDateLbl,getRangeBtn])
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.spacing = 5
        return sv
    }()
    
    lazy var getRangeBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Set Range", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: AppThemeConfig.boldFont, size: 13)
        btn.titleLabel?.textColor = .white
        btn.backgroundColor = AppThemeConfig.DarkGreen
        btn.addTarget(self, action: #selector(didTapOnGetRange), for: .touchUpInside)
        btn.rounded(cornerRadius: 6)
        return btn
    }()
    
    lazy var emptyWindowView : EmptyWindowView = {
        let view = EmptyWindowView(with: UIImage(), title: "Please select Date-Range to view future appointments")
        return view
    }()
    
    //MARK: - Actions
    @objc func didTapOnGetRange(){
        if let listner =  getDatesListener{
            listner()
        }
    }
    
    @objc func showCalendar(){
        if let listner =  getDatesListener{
            listner()
        }
    }
    
    
    func addViews(){
        addSubview(mainStackView)
        containerView.addSubview(dateStackView)
        addSubview(emptyWindowView)
        bringSubviewToFront(emptyWindowView)
    }
    
    func layoutUI(){
        
        let widthOfElement = self.frame.width / 3
        
        _ = mainStackView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        _ = containerView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil,size: .init(width: 0, height: 50))
        
        _ = emptyWindowView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        emptyWindowView.centerX(inView: self)
        emptyWindowView.centerY(inView: self)
        
        _ =  fromDateLbl.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: nil,padding: .init(top: 5, left: 5, bottom: 5, right: 0),size: .init(width: widthOfElement, height: 0))
        
        _ = toDateLbl.anchor(top: containerView.topAnchor, leading: nil, bottom: containerView.bottomAnchor, trailing: nil,padding: .init(top: 5, left: 5, bottom: 5, right: 0),size: .init(width: widthOfElement, height: 0))
        
        _ = toLbl.anchor(top: nil, leading: nil, bottom: nil, trailing: nil,size: .init(width: 30, height: 0))
        _ = getRangeBtn.anchor(top: nil, leading: nil, bottom: nil, trailing: containerView.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 5))

        _ = dateStackView.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor)
    
    }
    
    
}
