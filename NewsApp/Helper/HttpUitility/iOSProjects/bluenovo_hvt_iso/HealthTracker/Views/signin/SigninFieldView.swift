
//
//  SigninFieldView.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 27/07/21.
//
//

import UIKit

class SigninFieldView: ExtendedView {
    
    @IBOutlet var textField : UITextField?
    @IBOutlet fileprivate var borderView : UIView?
    @IBOutlet fileprivate var errorLabel : UILabel?
    @IBOutlet var image:UIImageView?
    @IBOutlet var textFieldContainer:UIView?
    
    var isCompleteBorderAllow = false
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        initialization()
    }
    
    fileprivate func initialization(){
        
        layoutUI()
        addtapGestureToImage()
    }
    
    fileprivate func layoutUI(){
        
        if isCompleteBorderAllow{
           
            self.textFieldContainer?.layer.borderWidth = 1
            self.textFieldContainer?.layer.borderColor = UIColor(hexString: AppThemeConfig.borderGrayColor).cgColor
            self.textFieldContainer?.layer.cornerRadius = 3
            self.textFieldContainer?.layer.masksToBounds = true
            borderView?.backgroundColor = UIColor.clear
            return
        }        
        borderView?.backgroundColor = UIColor(hexString: AppThemeConfig.borderGrayColor)
        self.layer.masksToBounds = true
    }
    
    func showError(text : String?){
       // borderView?.backgroundColor = UIColor.red
        errorLabel?.text = text
    }
    
    func resetErrorStatus(){
        
        if isCompleteBorderAllow {
            borderView?.backgroundColor = UIColor.clear
            errorLabel?.text = ""
            return
        }
        borderView?.backgroundColor = UIColor(hexString: AppThemeConfig.borderGrayColor)
        errorLabel?.text = ""
    }
    
    func addtapGestureToImage(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(protectPassowrd))
        image?.addGestureRecognizer(tapGesture)
        image?.isUserInteractionEnabled = true
    }
    
    @objc func protectPassowrd(){
        Log.echo(key: "hidePass", text: "tapped")
        
        if !(textField?.isSecureTextEntry ?? false){
            self.textField?.isSecureTextEntry = true
            image?.image = UIImage(systemName: "eye.slash")
        }else{
            self.textField?.isSecureTextEntry = false
            
            image?.image = UIImage(systemName: "eye")
        }
    }
}
