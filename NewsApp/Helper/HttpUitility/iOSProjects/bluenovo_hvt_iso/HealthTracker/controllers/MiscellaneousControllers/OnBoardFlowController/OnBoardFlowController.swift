//
//  OnBoardFlowController.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 28/07/21.
//

import Foundation


import UIKit

class OnBoardFlowController : InterfaceExtendedController{
    
    let TAG = "OnBoardFlowController"
    
    var didLoad:(()->())?
    
    var onBoardPageModel : [OnBoardFlowModal] = {
        let firstPage = OnBoardFlowModal(title: "At your Quick service".localized() ?? "", message: "24/7 available for your appointments".localized() ?? "", backgroundImg: "ic_slider_hand")
        
        let secondPage = OnBoardFlowModal(title: "Saving lives".localized() ?? "", message: "Saving lives of people by self visiting to them".localized() ?? "", backgroundImg: "ic_slider_kit")
        
        
        let thirdPage = OnBoardFlowModal(title: "The care you want".localized() ?? "", message: "Affordable and trusted care for you".localized() ?? "", backgroundImg: "ic_slider_logo")
        
        
        return [firstPage,secondPage,thirdPage]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }
    
    fileprivate func initialization(){
        initailizeVariable()
    }
    
    fileprivate func initailizeVariable(){
        rootView?.controller = self
        rootView?.flowCollectionView.delegate = self
        rootView?.flowCollectionView.dataSource = self
        rootView?.flowCollectionView.register(OnBoardFlowCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        hideNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        showNavigationBar()
    }
    
    var rootView : OnBoardFlowRootView?{
        return self.view as? OnBoardFlowRootView
    
    }
    
}


extension OnBoardFlowController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onBoardPageModel.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? OnBoardFlowCell else {
            return UICollectionViewCell()
        }
        cell.fillInfo(with: onBoardPageModel[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
      
        return CGSize(width: (view.frame.width), height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = targetContentOffset.pointee.x / view.frame.width
        
        Log.echo(key: "abhishekD", text: "current page Index\(pageNumber)")
        rootView?.pageControl.currentPage = Int(pageNumber)
        if Int(pageNumber)  == onBoardPageModel.count - 1 {
            rootView?.loginContainerBottomAnchor?.constant = -60
            hideNextButton()
        }else{
           rootView?.loginContainerBottomAnchor?.constant = 120
            showNextButtin()
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    func hideNextButton(){
        rootView?.nxtButton.isHidden = true
        rootView?.skipButton.isHidden = true
    }
    
    func showNextButtin(){
        rootView?.nxtButton.isHidden = false
        rootView?.skipButton.isHidden = false
    }
}
extension OnBoardFlowController {
    class func instance() -> OnBoardFlowController?{
        
        let storyboard = UIStoryboard(name: "onBoardFlow", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "onBoardFlow") as? OnBoardFlowController
        return controller
        
    }
}
