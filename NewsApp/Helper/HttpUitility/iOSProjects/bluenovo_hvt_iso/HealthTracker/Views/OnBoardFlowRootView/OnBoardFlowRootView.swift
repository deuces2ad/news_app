//
//  OnBoardFlowRootView.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 28/07/21.
//

import Foundation
import UIKit

class OnBoardFlowRootView: ExtendedView {
    
    override func viewDidLayout() {
        super.viewDidLayout()
        paintInterface()
    }
    
    var controller : OnBoardFlowController?
    var loginContainerBottomAnchor : NSLayoutConstraint?
    
    //MARK:- Properties
//    @IBOutlet weak var flowCollectionView : UICollectionView?
    
    func paintInterface(){
        setupView()
    }
    
    lazy var flowCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    lazy var pageControl : UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = UIColor(hexString: AppThemeConfig.themeGray)
        pc.currentPageIndicatorTintColor = UIColor(hexString: AppThemeConfig.greenColor)
       
        if let numberofPages = controller?.onBoardPageModel.count{
            Log.echo(key: "abhi", text: "ssdss")
            pc.numberOfPages = numberofPages
        }
        return pc
    }()
    
    lazy var skipButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = UIColor(hexString: AppThemeConfig.greenColor)
        btn.setTitle("Skip".localized() ?? "", for: .normal)
        btn.titleLabel?.font = UIFont(name: AppThemeConfig.boldFont, size: 18)
        btn.addTarget(self, action: #selector(skipAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var nxtButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = UIColor(hexString: AppThemeConfig.greenColor)
        btn.setTitle("Next".localized() ?? "", for: .normal)
        btn.titleLabel?.font = UIFont(name: AppThemeConfig.boldFont, size: 18)
        btn.addTarget(self, action: #selector(nextBtnAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var loginLoginBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .white
        btn.setTitle("Get Started".localized() ?? "", for: .normal)
        btn.titleLabel?.font = UIFont(name: AppThemeConfig.boldFont, size: 18)
        btn.addTarget(self, action: #selector(loginBtnAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var loginBtnContainer : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: AppThemeConfig.greenColor)
        view.addSubview(loginLoginBtn)
        return view
    }()
    
    //MARK:- Actions
    
    @objc func skipAction() {
        loginBtnAction()
    }
    
    @objc func nextBtnAction(){
        let pageNumber = pageControl.currentPage
        let indexpath = IndexPath(item: pageNumber + 1, section: 0)
        if pageNumber == 2{
            return
        }
        
        flowCollectionView.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage += 1
        flowCollectionView.scrollToNextItem()
       
        if pageNumber == 1{
                loginContainerBottomAnchor?.constant = -60
            nxtButton.isHidden = true
            skipButton.isHidden = true
        }else{
            nxtButton.isHidden = false
            skipButton.isHidden = false
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    func setupView(){
        addSubview(flowCollectionView)
        addSubview(pageControl)
        addSubview(skipButton)
        addSubview(nxtButton)
        addSubview(loginBtnContainer)
        
        _ = flowCollectionView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 20, right: 0))
        _ = pageControl.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: nil,padding: .init(top: 0, left: 0, bottom: 20, right: 0))
        
        _ = skipButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 20, left: 20, bottom: 0, right: 0))
        
        _ = nxtButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 20, left: 0, bottom: 0, right: 20))
        pageControl.centerX(inView: self)
        
        
        loginContainerBottomAnchor =  loginBtnContainer.anchor(top: nil, leading: leadingAnchor, bottom: self.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 30, bottom: -60, right: 30),size: .init(width: 0, height: 50))[2]
        
        
        _ = loginLoginBtn.anchor(top: self.loginBtnContainer.topAnchor, leading: self.loginBtnContainer.leadingAnchor, bottom: self.loginBtnContainer.bottomAnchor, trailing: self.loginBtnContainer.trailingAnchor)
        loginLoginBtn.centerX(inView: self)
    }
        
    
    @objc func loginBtnAction(){
        
        guard let controller = SigninController.instance() else{
            return
        }
        UserDefaults.standard.setValue(true, forKey: "isOnBoardShowed")
        self.controller?.navigationController?.pushViewController(controller, animated: true)
    }
    
   
}

extension UICollectionView {
    func scrollToNextItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x + self.bounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }
    func moveToFrame(contentOffset : CGFloat) {
            self.setContentOffset(CGPoint(x: contentOffset, y: self.contentOffset.y), animated: true)
        }
}
