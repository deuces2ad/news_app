//
//  UserLocationMarkerInfoWindow.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 08/08/21.
//

protocol UserLocationMarkerInfoWindowDelegate: class {
  func didTapConfirmPickupLocation()
}

import UIKit


class UserLocationMarkerInfoWindow: ExtendedView {
  
  // MARK: - Properties
  private lazy var windowBGImgView: UIImageView = {
    let imgView = UIImageView()
    imgView.image = UIImage(named: "user_current_location_info_bg")?.withTintColor(AppThemeConfig.DarkGreen, renderingMode: .alwaysOriginal)
    imgView.contentMode = .scaleAspectFit
    return imgView
  }()
  
  private lazy var confirmLocationBtn: UIButton = {
    let btn = UIButton()
    btn.titleLabel?.font = UIFont(name: AppThemeConfig.boldFont, size: 14)
    btn.titleLabel?.textAlignment = .center
    btn.titleLabel?.baselineAdjustment = .alignCenters
    btn.titleLabel?.adjustsFontSizeToFitWidth = true
    btn.setTitle("CONFIRM YOUR LOCATION", for: .normal)
    btn.addTarget(self, action: #selector(confirmLocationAction), for: .touchUpInside)
    return btn
  }()
  
  private weak var delegate: UserLocationMarkerInfoWindowDelegate?
  
  // MARK: - Instance Creation Helpers
  init(delegate: UserLocationMarkerInfoWindowDelegate?) {
    super.init(frame: .zero)
    self.delegate = delegate
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  // MARK: - LifeCycle
  override func viewDidLayout() {
    super.viewDidLayout()
    addSubViews()
    layoutUI()
    initializeVariables()
  }
  
  // MARK: - @objc Helpers
  @objc
  func confirmLocationAction() {
    self.delegate?.didTapConfirmPickupLocation()
  }
}

// MARK: - Add Sub View
extension UserLocationMarkerInfoWindow {
  func addSubViews() {
    self.addSubview(windowBGImgView)
    self.addSubview(confirmLocationBtn)
  }
}

// MARK: - Layout Sub Views
extension UserLocationMarkerInfoWindow {
  func layoutUI() {
    _ = windowBGImgView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    _ = confirmLocationBtn.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 5, bottom: 5, right: 5))
  }
}

// MARK: - Initialize Variables
extension UserLocationMarkerInfoWindow {
  func initializeVariables() {
    self.clipsToBounds = false
    self.applyShadow(apply: true, color: UIColor(hexString: "#3E4958"), offset: .init(width: 0, height: 2), opacity: 0.2, radius: 5, shadowRect: nil)
  }
}

