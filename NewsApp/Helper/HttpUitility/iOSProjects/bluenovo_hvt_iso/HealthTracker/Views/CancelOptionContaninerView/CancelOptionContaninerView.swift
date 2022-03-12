//
//  CancelOptionContaninerView.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 17/09/21.
//

import Foundation
import UIKit


class  CancelOptionContaninerView: ExtendedView {
    
    var title : CancellationReason?
    var TAG = "CancelOptionContaninerView"
    var didTapOnSelection : ((Bool)->())?
    var delegate : DidMadeSelectionDelegate?
    
    override func viewDidLayout() {
        super.viewDidLayout()
        setupViews()
        layoutUI()
        backgroundColor = .clear
    }

    
    init(title : CancellationReason,delegate : DidMadeSelectionDelegate) {
        super.init(frame: .zero)
        self.title = title
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Properties
    
    
    lazy var containerView : UIView = {
        let view = UIView()
        return view
    }()
    
    
    
    lazy var selectedImg : UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    lazy var optionlbl : UILabel = {
        let lbl = UILabel()
        lbl.text = title?.rawValue.localized()
        lbl.font = UIFont(name: AppThemeConfig.defaultFont, size: 12)
        return lbl
    }()
    
    lazy var selectionBtn : UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(didTapOnChooseOption), for: .touchUpInside)
        return btn
    }()
    
    func setupViews(){
        addSubview(containerView)
        containerView.addSubview(selectedImg)
        containerView.addSubview(optionlbl)
        containerView.addSubview(selectionBtn)
    }
    
    //MARK:- Action or Objc functions
    @objc func didTapOnChooseOption(){
        Log.echo(key: TAG, text: "didTapOnChooseOption")
        if title == CancellationReason.other{
            delegate?.didMadeSelection(type: .other)
        }else{
            delegate?.didMadeSelection(type: title!)
        }
    }
    
    
    func layoutUI(){
        _  =  containerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 5, left: 10, bottom: 5, right: 10),size: .init(width: 0, height: 0))
        
        _ = selectedImg.anchor(top: nil, leading: containerView.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 0, left: 10, bottom: 0, right: 30),size: .init(width: 15, height: 15))
        selectedImg.centerY(inView: containerView)
        
        _ = optionlbl.anchor(top: containerView.topAnchor, leading: selectedImg.trailingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 0, left: 10, bottom: 0, right: 0))
        optionlbl.centerY(inView: selectedImg)
        
        _ = selectionBtn.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor)
    }
    
    func selected(){
        containerView.backgroundColor = AppThemeConfig.LightGreen.withAlphaComponent(0.35)
        selectedImg.image = #imageLiteral(resourceName: "icons8-unchecked-radio-button-100")
    }
    
    func deSelected(){
        selectedImg.image = #imageLiteral(resourceName: "ic_RadioUnchecked")
    }
    
}
