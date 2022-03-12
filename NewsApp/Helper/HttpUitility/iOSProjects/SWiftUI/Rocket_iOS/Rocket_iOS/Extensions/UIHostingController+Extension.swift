//
//  UIHostingController+Extension.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 18/12/21.
//

import Foundation
import SwiftUI
import UIKit

class ExtendedHostingController <Content>: UIHostingController<AnyView> where Content : View {

  public init(shouldShowNavigationBar: Bool, rootView: Content) {
      super.init(rootView: AnyView(rootView.navigationBarHidden(!shouldShowNavigationBar)))
  }

  @objc required dynamic init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
}
