//
//  EditProfileController.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 31/07/21.
//

import Foundation
import UIKit

class EditProfileController: InterfaceExtendedController {
    
    let TAG = "EditProfileController"
    
    var imagePicker : ImagePicker?
    var delegate : SetImageDelegate?
    var profileImgData = UIImage()
    
    //MARK:-LifeCyle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
        
    }
    
    override func loadView() {
        super.loadView()
        self.view = rootView
    }
    
    
    fileprivate func initialization(){
        rootView.controller = self
        initializevarible()
        paintInterface()
    }
    
    fileprivate func initializevarible(){
        self.imagePicker = ImagePicker(presentationControler: self, delegate: self)
        
        rootView.fillInfo(with: SignedUserInfo.sharedInstance)
    }
    
    fileprivate func  paintInterface(){
        paintBackButton()
        paintNavigationTitle(text: "Edit Profile".localized())
    }
    //MARK:- Properties
    lazy  var rootView : EditProfileRootView = {
        let rootView = EditProfileRootView()
        return rootView
    }()
    
    func saveChnages(){
        delegate?.setImage(with: profileImgData)
        self.navigationController?.popViewController(animated: true)
    }
    
    func fethcLocation(){
        self.navigationController?.pushViewController(FetchAddressController(), animated: true)
    }
    func showImagePicker(){
        guard let controller = imagePicker else{
            return
        }
        controller.present(from: self.view)
    }
}

extension EditProfileController :ImagePickerDelegate {
    func didFinishSelectImage(with image: UIImage?) {
        Log.echo(key: TAG, text: "I found the profile image : \(String(describing: image))")
        profileImgData = image!
        rootView.profileImg.image = profileImgData
    }
}
