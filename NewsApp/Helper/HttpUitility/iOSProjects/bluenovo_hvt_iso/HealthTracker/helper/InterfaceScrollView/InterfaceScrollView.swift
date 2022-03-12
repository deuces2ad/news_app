//
//  InterfaceScrollView.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 31/07/21.
//

import UIKit

class InterfaceScrollView: UIScrollView {
  
  private var isLoaded = false
  var scrollContainerView: UIView?
  var bottomContentOffset: NSLayoutConstraint?
  var activeField: UIView?
  override var adjustedContentInset: UIEdgeInsets {
    return UIEdgeInsets()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    if(!isLoaded){
      isLoaded = true
      viewDidLayout()
      setupView()
    }
  }
  
  func viewDidLayout() {
    if #available(iOS 11.0, *) {
      self.contentInsetAdjustmentBehavior = .never
    }
    registerForKeyboardNotifications()
    registerForTapGestureForKeyboardResign()
  }
  
  init() {
    super.init(frame: .zero)
    let view = UIView()
    view.backgroundColor = .clear
    addSubview(view)
    self.scrollContainerView = view
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  func setupView() {
    scrollContainerView?.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
    bottomContentOffset = scrollContainerView?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
    NSLayoutConstraint.activate([(bottomContentOffset ?? NSLayoutConstraint())])
    scrollContainerView?.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0).isActive = true
    self.bounces = false
  }
}

// MARK: - TAP GESTURE
extension InterfaceScrollView {
  
  fileprivate func registerForTapGestureForKeyboardResign(){
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
    tapGesture.cancelsTouchesInView = false
    self.addGestureRecognizer(tapGesture)
  }
  
  @objc func hideKeyboard() {
    self.endEditing(true)
  }
}

// MARK: - KEYBOARD HANDLING
extension InterfaceScrollView {
  
  fileprivate func registerForKeyboardNotifications(){
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name:UIResponder.keyboardWillHideNotification , object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name:UIResponder.keyboardWillShowNotification , object: nil)
    
  }
  
  fileprivate func unregisterForKeyboardNotifications(){
    
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  @objc func keyboardWillHide(_ notification : Notification){
    _ = adjustForKeyboard(notification, shouldIncreaseOffset: false)
  }
  
  @objc func keyboardWillShow(_ notification : Notification){
    scrollToIncreaseOffset(true, notification: notification)
  }
  
  fileprivate func adjustForKeyboard(_ notification : Notification, shouldIncreaseOffset : Bool)->CGFloat{
    
    let info = (notification as NSNotification).userInfo
    let keyboardSize = (info?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
    let keyboardHeight = keyboardSize?.height ?? 255.0
    return adjustForHeight(keyboardHeight, shouldIncreaseOffset: shouldIncreaseOffset)
  }
  
  fileprivate func adjustForHeight(_ keyboardHeight : CGFloat, shouldIncreaseOffset : Bool)->CGFloat{
    
    guard let contentOffset = self.bottomContentOffset?.constant
    else{
      return keyboardHeight
    }
    
    if(shouldIncreaseOffset && keyboardHeight != contentOffset)
    {
      self.updateScrollViewContentOffset(keyboardHeight)
      return keyboardHeight;
    }
    
    if(!shouldIncreaseOffset && contentOffset != 0)
    {
      self.updateScrollViewContentOffset(0)
      return keyboardHeight;
    }
    
    return keyboardHeight
  }
  
  fileprivate func updateScrollViewContentOffset(_ contentOffset : CGFloat){
    
    self.layoutIfNeeded()
    self.bottomContentOffset?.constant = contentOffset
    self.contentOffset = CGPoint(x: CGFloat(0.0), y: CGFloat(0.0))
    UIView.animate(withDuration: 0.3, animations: {
      self.layoutIfNeeded()
    })
  }
  
  fileprivate func scrollToIncreaseOffset(_ shouldIncreaseOffset : Bool, notification : Notification){
    
    let keyboardHeight = adjustForKeyboard(notification, shouldIncreaseOffset: shouldIncreaseOffset)
    
    let screenSize = self.bounds.size
    let viewWidth = screenSize.width
    let viewHeight = screenSize.height
    
    let viewableAreaFrame = CGRect(x: 0.0, y: 0.0, width: viewWidth, height: viewHeight - keyboardHeight)
    
    guard let activeFieldUW = activeField
    else{
      return
    }
    let activeFieldOrigin = activeFieldUW.convert(activeFieldUW.bounds.origin, to: self)
    
    let scrollViewUW = self
    
    let scrollViewOrigin = scrollViewUW.convert(scrollViewUW.bounds.origin, to: nil)
    
    let activeFieldSize = activeFieldUW.bounds.size
    
    var activeFieldFrame = CGRect.zero
    activeFieldFrame.size = activeFieldSize
    activeFieldFrame.origin = CGPoint(x: activeFieldOrigin.x, y: activeFieldOrigin.y + scrollViewOrigin.y)
    
    let scrollCount = activeFieldOrigin.y + scrollViewOrigin.y + 10 + activeFieldSize.height - (viewHeight - keyboardHeight);
    
//    print("viewableAreaFrame  --> \(viewableAreaFrame) activeFieldFrame-->\(activeFieldFrame)")
    
    if(!viewableAreaFrame.contains(activeFieldFrame)){
      self.contentOffset = CGPoint(x: CGFloat(0.0), y: scrollCount)
    }
  }
}
