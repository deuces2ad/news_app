//
//  CheckupRootView.swift
//  HealthTracker
//
//  Created by Apple on 07/10/21.
//

import Foundation
import UIKit

class CheckupRootView : ExtendedView {
    
    var controller : CheckupController?
    
    override func viewDidLayout() {
        super.viewDidLayout()
        backgroundColor = .white
        setupViews()
        layoutUI()
    }
    
    //MARK: - Propties
    lazy var scrollView: InterfaceScrollView = {
      let scrollView = InterfaceScrollView()
        scrollView.backgroundColor = .clear
      return scrollView
    }()
    
    private lazy var containerView: UIView = {
      let view = UIView()
      view.backgroundColor = .white
      return view
    }()
    
    lazy var backgrndCurve : UIView = {
        let view = UIView()
        view.backgroundColor = AppThemeConfig.DarkGreen
        view.roundCorners([.layerMaxXMaxYCorner, .layerMinXMaxYCorner], radius:60)
        return view
    }()
    
    lazy var basicInfoContainerView : UIView = {
        let cv = UIView()
        cv.backgroundColor = .white
        cv.applyShadow(apply: true, color: .lightGray, offset: CGSize(width: 0, height: 10), opacity: 1.2, radius: 10, shadowRect: nil)
        cv.layer.cornerRadius = 6
        return cv
    }()
    
    private lazy var staffName: PersonalInfoTextFieldView = {
        let fieldView = PersonalInfoTextFieldView(header: "First Name", placeHolder: "First name", isRequired: true, image: UIImage(systemName: "person.fill")?.withTintColor(AppThemeConfig.LightGreen, renderingMode: .alwaysOriginal) ?? UIImage(), textFiledDelegate: self.controller ?? InterfaceExtendedController())
        fieldView.isUserInteractionEnabled = false
      return fieldView
    }()
    
    lazy var patinetNameLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "Patient Name : Sylvia"
        lbl.font = UIFont(name: AppThemeConfig.defaultFont, size: 18)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private lazy var staffEmail: PersonalInfoTextFieldView = {
        let fieldView = PersonalInfoTextFieldView(header: "Email".localized() ?? "", placeHolder: "Email Address", isRequired: true, image: UIImage(systemName: "mail.fill")?.withTintColor(AppThemeConfig.LightGreen, renderingMode: .alwaysOriginal) ?? UIImage(), textFiledDelegate: self.controller ?? InterfaceExtendedController())
        fieldView.isUserInteractionEnabled = false
      return fieldView
    }()
    
    lazy var textView : UITextView = {
        let tv = UITextView()
        tv.layer.cornerRadius = 6
        tv.layer.borderWidth = 1.5
        tv.layer.borderColor = AppThemeConfig.DarkGreen.cgColor
        tv.text = "Enter Remarks"
        tv.textColor = UIColor.lightGray
        tv.font = UIFont(name: AppThemeConfig.defaultFont, size: 14)
        tv.delegate = self
        return tv
    }()
    
    lazy var savebtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(didTapOnDoneBtn), for: .touchUpInside)
        btn.backgroundColor = AppThemeConfig.DarkGreen
        btn.setTitle("Save", for: .normal)
        btn.layer.cornerRadius = 6
        btn.tintColor = .white
        btn.titleLabel?.font = UIFont(name: AppThemeConfig.boldFont, size: 13)
        return btn
    }()
    
    fileprivate func setupViews(){
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(backgrndCurve)
        containerView.addSubview(basicInfoContainerView)
        basicInfoContainerView.addSubview(patinetNameLbl)
        basicInfoContainerView.addSubview(textView)
        basicInfoContainerView.addSubview(savebtn)
    }
    
    @objc func didTapOnDoneBtn(){
        
    }
    
    fileprivate func layoutUI(){
        
        _ = scrollView.anchor(top: topAnchor, leading: leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor)
         
         
         _ = containerView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor)
        
        _ = backgrndCurve.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor)
        
          backgrndCurve.heightEqualToView(self, multiplier: 0.3)
        
        _ = basicInfoContainerView.anchor(top: backgrndCurve.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor,padding: .init(top: -20, left: 30, bottom: 0, right: 30))
        
        _ = patinetNameLbl.anchor(top: basicInfoContainerView.topAnchor, leading: basicInfoContainerView.leadingAnchor, bottom: nil, trailing: basicInfoContainerView.trailingAnchor,padding: .init(top: 10, left: 20, bottom: 20, right: 15))
        
        _ = textView.anchor(top: patinetNameLbl.bottomAnchor, leading: basicInfoContainerView.leadingAnchor, bottom: nil, trailing: basicInfoContainerView.trailingAnchor,padding: .init(top: 20, left: 20, bottom: 20, right: 20),size: .init(width: 0, height: 70))
        
        _ = savebtn.anchor(top: textView.bottomAnchor, leading: nil, bottom: basicInfoContainerView.bottomAnchor, trailing: nil,padding: .init(top: 20, left: 0, bottom: 20, right: 0),size: .init(width: 50, height: 0))
        savebtn.centerX(inView: textView)
        
    
    }
}

extension CheckupRootView : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter Remarks"
            textView.textColor = UIColor.lightGray
        }
    }
}
