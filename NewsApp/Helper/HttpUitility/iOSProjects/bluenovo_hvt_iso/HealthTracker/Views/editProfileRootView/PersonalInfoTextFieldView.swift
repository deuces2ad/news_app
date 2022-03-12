//
//  PersonalInfoTextFieldView.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 31/07/21.
//

import UIKit

final class PersonalInfoTextFieldView: ExtendedView {
  
  //MARK: - Properties
  private lazy var headerLbl: UILabel = {
    let lbl = UILabel()
    lbl.textAlignment = .center
    lbl.adjustsFontSizeToFitWidth = true
    lbl.font = UIFont(name: AppThemeConfig.defaultFont, size: 12)
    return lbl
  }()
  
  lazy var infoTxtField: UITextField = {
    let tf = UITextField()
    tf.borderStyle = .none
    tf.font = UIFont(name: AppThemeConfig.defaultFont, size: 16)
    tf.autocorrectionType = .no
    return tf
  }()
  
  private lazy var infoImgView: UIImageView = {
    let imgView = UIImageView()
    imgView.contentMode = .scaleAspectFit
    return imgView
  }()
  
  var isRequired = false
  
  //MARK: - LifeCycle
  init(header: String, placeHolder: String, isRequired: Bool, image: UIImage, textFiledDelegate: InterfaceExtendedController) {
      super.init(frame: .null)
    self.isRequired = isRequired
    self.headerLbl.text = header
    if !isRequired{
        self.headerLbl.text! = ""
    }
      
 
    self.infoTxtField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [.font : UIFont(name: AppThemeConfig.defaultFont, size: 16), .foregroundColor: UIColor(hexString: "#838383")])
    self.infoTxtField.delegate = textFiledDelegate as? UITextFieldDelegate
    self.infoImgView.image = image
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func viewDidLayout() {
    super.viewDidLayout()
    addSubViews()
    layoutUI()
  }
}

// MARK: - Add Sub Views
extension PersonalInfoTextFieldView {
  private func addSubViews() {
    self.addSubview(headerLbl)
    self.addSubview(infoTxtField)
    self.addSubview(infoImgView)
  }
}

// MARK: - Layout Sub Views
extension PersonalInfoTextFieldView {
  private func layoutUI() {
      _ = headerLbl.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 10, left: 20, bottom: 0, right: 0))
    
    _ = infoImgView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 20, bottom: 5, right: 0), size: .init(width: 20, height: 20))
    infoImgView.centerY(inView: infoTxtField)
      
      
    
    _ = infoTxtField.anchor(top: headerLbl.bottomAnchor, leading: self.infoImgView.trailingAnchor, bottom: self.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: 5, right: 5))
    let separtor = UIView()
    separtor.backgroundColor = UIColor(hexString: "#C4C4C4")
    self.addSubview(separtor)
    separtor.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, size: .init(width: 0, height: 1))
  }
}

