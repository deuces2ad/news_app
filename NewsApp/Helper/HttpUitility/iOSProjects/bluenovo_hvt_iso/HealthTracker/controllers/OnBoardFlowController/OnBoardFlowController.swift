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
        let firstPage = OnBoardFlowModal(title: "At Your Quick Service", message: "24/7 available for your appointments", backgroundImg: "ic_slider_hand")
        
        let secondPage = OnBoardFlowModal(title: "Saving Lives", message: "Saving life of People by self Visiting to them", backgroundImg: "ic_slider_kit")
        
        
        let thirdPage = OnBoardFlowModal(title: "The care you want", message: "Affordable and trusted care for you", backgroundImg: "ic_slider_logo")
        
        
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
        }else{
           rootView?.loginContainerBottomAnchor?.constant = 120
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
}
extension OnBoardFlowController {
    class func instance() -> OnBoardFlowController?{
        
        let storyboard = UIStoryboard(name: "onBoardFlow", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "onBoardFlow") as? OnBoardFlowController
        return controller
        
    }
}
