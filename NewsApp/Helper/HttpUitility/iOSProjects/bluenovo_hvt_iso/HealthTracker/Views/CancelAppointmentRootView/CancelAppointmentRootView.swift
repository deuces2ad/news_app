//
//  CancelAppointmentRootView.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 17/09/21.
//

import Foundation
import UIKit


class CancelAppointmentRootView: ExtendedView {
    
    
    //MARK:- Properties
    var controller : CancelAppointmentController?
    var textViewHeightAnchor : NSLayoutConstraint?
    var deleate : CancelAppointmentDelegate?
    var cancelationReason = String()
    
    //MARK:-LifeCylce
    override func viewDidLayout() {
        super.viewDidLayout()
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        setupViews()
        layoutUI()
        textViewHeightAnchor?.constant = 0
        preselecatedOption()
    
    }
    
    func preselecatedOption(){
        resetSelection()
        reasOne1.selected()
        cancelationReason = CancellationReason.notAvailable.rawValue
    }
    
    //MARK:- Properties
    lazy var containerView : UIView = {
        let view = UIView()
        view.backgroundColor = AppThemeConfig.LightGreen
        view.layer.cornerRadius = 6
        return view
    }()
    
    
    lazy var cancelDisciptionLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "Reason for Cancellation"
        lbl.textAlignment = .center
        lbl.font = UIFont(name: AppThemeConfig.defaultFont, size: 14)
        return lbl
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
    
    lazy var closeBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(didTapOnCloseBtn), for: .touchUpInside)
        btn.backgroundColor = UIColor(hexString: "#840010")
        btn.setTitle("Close", for: .normal)
        btn.layer.cornerRadius = 6
        btn.tintColor = .white
        btn.titleLabel?.font = UIFont(name: AppThemeConfig.boldFont, size: 13)
        return btn
    }()
    
    lazy var sepratorView : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    lazy var reasOne1 : CancelOptionContaninerView = {
        let view = CancelOptionContaninerView(title: CancellationReason.notAvailable, delegate: self)
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var reasOne2 : CancelOptionContaninerView = {
        let view = CancelOptionContaninerView(title: CancellationReason.doNotRequire, delegate: self)
        return view
    }()
    
    lazy var reasOne3 : CancelOptionContaninerView = {
        let view = CancelOptionContaninerView(title: CancellationReason.conflictingAppointment, delegate: self)
        return view
    }()
    
    lazy var reasOne4 : CancelOptionContaninerView = {
        let view = CancelOptionContaninerView(title: CancellationReason.other, delegate: self)
        return view
    }()
    

    lazy var stackView : UIStackView = {
        let stack = UIStackView(arrangedSubviews: [reasOne1,reasOne2,reasOne3,reasOne4])
        stack.axis = .vertical
        return stack
    }()
    
    lazy var textView : UITextView = {
        let tv = UITextView()
        tv.layer.cornerRadius = 6
        tv.layer.borderWidth = 1.5
        tv.layer.borderColor = AppThemeConfig.DarkGreen.cgColor
        tv.text = "Enter reason for cancellation..."
        tv.textColor = UIColor.lightGray
        tv.font = UIFont(name: AppThemeConfig.defaultFont, size: 14)
        tv.delegate = self
        return tv
    }()
    
    lazy var optionContainerStackView : UIStackView = {
        let view = UIStackView(arrangedSubviews: [closeBtn,savebtn])
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 5
        return view
    }()

    
    //MARK:- Action or Objc functions
    @objc func didTapOnDoneBtn(){
        Log.echo(key: "CancelAppointmentRootView", text: "didTapOnDoneBtn")
        controller?.dismiss(animated: false, completion: nil)
        deleate?.appointmentDidGotCancel(with: cancelationReason)
        
    }
    
    @objc func didTapOnCloseBtn(){
        Log.echo(key: "CancelAppointmentRootView", text: "didTapOnCloseBtn")
        controller?.dismiss(animated: false, completion: nil)
    }
    
    
     //MARK:- SetupView
    func setupViews(){
        addSubview(containerView)
        containerView.addSubview(cancelDisciptionLbl)
        containerView.addSubview(sepratorView)
        containerView.addSubview(stackView)
        containerView.addSubview(textView)
        containerView.addSubview(optionContainerStackView)
    }
    

    
    //MARK:- Layout UI
    func layoutUI(){
        
        _ = containerView.anchor(top: nil, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor,padding: .init(top: 100, left: 30, bottom: 0, right: 30),size: .init(width: 300, height: 0))
        containerView.centerX(inView: self)
        containerView.centerY(inView: self)
        
        _ = cancelDisciptionLbl.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor,padding: .init(top: 5, left: 10, bottom: 0, right: 10))
        
        _ = sepratorView.anchor(top: cancelDisciptionLbl.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor,padding: .init(top: 5, left: 10, bottom: 0, right: 10),size: .init(width: 0, height: 0.5))
        
        _ = stackView.anchor(top: sepratorView.bottomAnchor, leading: cancelDisciptionLbl.leadingAnchor, bottom: nil, trailing: cancelDisciptionLbl.trailingAnchor)
        
        _ = textView.anchor(top: stackView.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor,padding: .init(top: 0, left: 10, bottom: 0, right: 10))
            
        textViewHeightAnchor = textView.heightAnchor.constraint(equalToConstant: 70)
        textViewHeightAnchor?.isActive = true
        
        _ = optionContainerStackView.anchor(top: textView.bottomAnchor, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        
    }
    //MARK:-Handle selection
    func selection(optionType type : CancellationReason){
        resetSelection()
        switch type {
        case .notAvailable:
            reasOne1.selected()
        case .doNotRequire:
            reasOne2.selected()
        case .conflictingAppointment:
            reasOne3.selected()
        default:
            reasOne4.selected()
        }
    }
    
    func resetSelection(){
        reasOne1.deSelected()
        reasOne2.deSelected()
        reasOne3.deSelected()
        reasOne4.deSelected()
    }
}

extension CancelAppointmentRootView : DidMadeSelectionDelegate{
    func didMadeSelection(type: CancellationReason) {
        Log.echo(key: "abhii!!", text: "\(type.rawValue) is selected")
        
        selection(optionType: type)
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
            if type == .other {
                self.textViewHeightAnchor?.constant = 70
                self.cancelationReason = self.textView.text
            }else{
                self.textViewHeightAnchor?.constant = 0
                self.cancelationReason = type.rawValue
            }
        }, completion: nil)
        layoutIfNeeded()
        
    }
}

extension CancelAppointmentRootView : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter resason for cancellation..."
            textView.textColor = UIColor.lightGray
        }
        self.cancelationReason = textView.text
    }
}


