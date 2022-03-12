//
//  SetLanguageRootView.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 01/09/21.
//

import Foundation
import UIKit

class SetLanguageRootView: ExtendedView {
    
    var controller : SetLanguageController?
    var defaultLanguage = "en"
    
    override func viewDidLayout() {
        super.viewDidLayout()
        backgroundColor = .white
        Initialization()
    }
    
     //MARK:-Initialization
    func Initialization(){
        SetupViews()
        LayoutUI()
        langEnglishContainer.buttn.addTarget(self, action: #selector(didSelectEnglish), for: .touchUpInside)
        langSpanishContainer.buttn.addTarget(self, action: #selector(didSelectSpanish), for: .touchUpInside)
        fetchDeviceLanguage()
        
    }
    
    func fetchDeviceLanguage(){
        guard let deviceLanguage = Locale.current.languageCode else {
            Log.echo(key: "abhi", text: "Not able to find the device language")
            return
        }
        Log.echo(key: "abhi", text: "detacted Language is \(deviceLanguage)")
        deviceLanguage == "es" ? langSpanishContainer.selected() : langEnglishContainer.selected()
        self.defaultLanguage = deviceLanguage
        
    }
    
    //MARK:- Properties
    lazy var imgView : UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "ic_slider_logo")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    lazy var userNameLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "Welcome..!!\n\(String(describing: self.getuserName()))"
        lbl.textAlignment = .center
        lbl.textColor = .black
        lbl.numberOfLines  = 0
        lbl.font = UIFont(name: AppThemeConfig.boldFont, size: 30)
        return lbl
    }()
    
    lazy var infotext : UILabel = {
        let lbl = UILabel()
        lbl.text = "Choose Language / elige lengua"
        lbl.textAlignment = .center
        lbl.textColor = .black
        lbl.numberOfLines  = 0
        lbl.font = UIFont(name: AppThemeConfig.boldFont, size: 15)
        return lbl
    }()
    
    lazy var langEnglishContainer : OptionContainerView = {
        let view = OptionContainerView(title: "English / ingles", countryName: "ic_usa")
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    lazy var langSpanishContainer : OptionContainerView = {
        let view = OptionContainerView(title: "Spanish / Español", countryName: "ic_spain")
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        
        return view
    }()
    
    lazy var stackView : UIStackView = {
        let view = UIStackView(arrangedSubviews: [langEnglishContainer,langSpanishContainer])
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 5
        return view
    }()
    
    lazy var doneBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(didTapOnDone), for: .touchUpInside)
        btn.setTitle("Continue / Seguir", for: .normal)
        btn.tintColor = .white
        btn.titleLabel?.textColor = .white
        btn.backgroundColor = AppThemeConfig.DarkGreen
        btn.layer.cornerRadius = 15
        return btn
    }()
    
    //MARK:- Action or Objc functions
    
    @objc func didSelectEnglish(){
        langEnglishContainer.selected()
        langSpanishContainer.deSelected()
        defaultLanguage = "en"
    }
    
    @objc func didSelectSpanish(){
        langSpanishContainer.selected()
        langEnglishContainer.deSelected()
        defaultLanguage = "es"
    }
    
    @objc func didTapOnDone(){
        
        UserDefaults.standard.setValue(defaultLanguage, forKey: LanguageKey)
        controller?.setTabBar()
    }
   
    
     //MARK:- SetupView
    func SetupViews(){
        addSubview(infotext)
        addSubview(stackView)
        addSubview(doneBtn)
    }
    
    //MARK:- Layout UI
    func LayoutUI(){
        
        _ = infotext.anchor(top: nil, leading: nil, bottom: stackView.topAnchor, trailing: nil,padding: .init(top: 20, left: 0, bottom: 10, right: 0))
        infotext.centerX(inView: self)
        
        _ = stackView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 20, left: 20, bottom: 0, right: 20),size: .init(width: 0, height: 100))
        stackView.centerXY(inView: self)
        
        
        _ = doneBtn.anchor(top:nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 20, bottom: 50, right: 20),size: .init(width: 0, height: 50))

        
    }
    
    func getuserName()->String{
        guard let userName = SignedUserInfo.sharedInstance?.name else {
            return "nil"
        }
        return userName
    }
    
}
