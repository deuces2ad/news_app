//
//  ProfileRootView.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 31/07/21.
//

import Foundation
import UIKit

class ProfileRootView: ExtendedView {
    
    let TAG = "ProfileRootView"
    var controller : MyProfileController?
    
    
    //MARK:- :Life cycle
    override func viewDidLayout() {
        super.viewDidLayout()
        backgroundColor = .systemTeal
        paintInterface()
    }
    
    
    private func paintInterface(){
        setupView()
        layoutUI()
    }
    lazy var profilePic : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "dummyProfile")
        return iv
    }()
    
    lazy var bottomContainerStack : UIStackView = {
        let sv = UIStackView()
        sv.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        sv.addArrangedSubview(editProfileBtn)
        sv.addArrangedSubview(settingBtn)
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        return sv
    }()
    
    lazy var userNamelbl : UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .white
        lbl.text = "Name: Abhishek Dhiman"
        lbl.font = UIFont(name: AppThemeConfig.boldFont, size: 18)
        return lbl
    }()
    
    lazy var userEmailIdlbl : UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .white
        lbl.text = "email: abhishekdhiman1408@gmail.com"
        lbl.font = UIFont(name: AppThemeConfig.boldFont, size: 18)
        return lbl
    }()
    
    lazy var userAddresslbl : UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .white
        lbl.text = "Name: Abhishek Dhiman"
        lbl.font = UIFont(name: AppThemeConfig.boldFont, size: 18)
        return lbl
    }()

    
    
    lazy var  settingBtn : ButtonContainerView = {
        let btn = ButtonContainerView(button: gearBtn, subHeading: "Setting")
        return btn
    }()
    
    lazy var  editProfileBtn : ButtonContainerView = {
        let btn = ButtonContainerView(button: pencilbtn, subHeading: "Edit Profile")
        return btn
    }()
    
    
    lazy var gearBtn : UIButton = {
       let btn = UIButton()
       btn.setImage(UIImage(systemName: "gearshape")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
       btn.addTarget(self, action: #selector(settingBtnAction), for: .touchUpInside)
       return btn
   }()
   
   lazy var pencilbtn : UIButton = {
      let btn = UIButton()
      btn.setImage(UIImage(systemName: "pencil")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
      btn.addTarget(self, action: #selector(editProfileAction), for: .touchUpInside)
      return btn
  }()
   
    
    lazy var alphaView : UIView = {
        let uv = UIView()
        uv.backgroundColor = .black.withAlphaComponent(0.5)
        return uv
    }()
//MARK:-LOAD PROFILE INFO
    
    func loadProfileInfo(with info : SignedUserInfo){
        
        self.userNamelbl.text = info.name
        self.userEmailIdlbl.text = info.email
        self.userAddresslbl.text = info.address
        
    }
    
    //MARK:- Actions

    @objc func settingBtnAction(){
        Log.echo(key: TAG, text: "SETTING ACTION GOT TAPPED")
    }
    
    @objc func editProfileAction(){
        Log.echo(key: TAG, text: "EDIT PROFILE ACTION GOT TAPPED")
        let editProfileVC = EditProfileController()
        editProfileVC.delegate = self
        controller?.navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    
    fileprivate func setupView(){
        addSubview(profilePic)
        addSubview(alphaView)
        addSubview(bottomContainerStack)
        addSubview(userNamelbl)
        addSubview(userEmailIdlbl)
        addSubview(userAddresslbl)
    }
    
    fileprivate func layoutUI(){
        _ = profilePic.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor)
        
        _ = alphaView.anchor(top: profilePic.topAnchor, leading: leadingAnchor, bottom:bottomAnchor , trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 2, right: 0))
                
        _ = userNamelbl.anchor(top: nil, leading: leadingAnchor, bottom: userEmailIdlbl.topAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 20, bottom: 20, right: 20))
        
        _ = userEmailIdlbl.anchor(top: nil, leading: leadingAnchor, bottom: userAddresslbl.topAnchor, trailing: trailingAnchor,padding: .init(top: 10, left: 20, bottom: 20, right: 20))
        
        _ = userAddresslbl.anchor(top: nil, leading: leadingAnchor, bottom: bottomContainerStack.topAnchor, trailing: trailingAnchor,padding: .init(top: 10, left: 20, bottom: 20, right: 20))
        
        _ = bottomContainerStack.anchor(top: profilePic.bottomAnchor, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 0),size: .init(width: 0, height: 50))
    
        
    }
    
}

extension ProfileRootView : SetImageDelegate{
    func setImage(with image: UIImage) {
        Log.echo(key: TAG, text: "Got image")
        self.profilePic.image = image
    }
    
    
}
