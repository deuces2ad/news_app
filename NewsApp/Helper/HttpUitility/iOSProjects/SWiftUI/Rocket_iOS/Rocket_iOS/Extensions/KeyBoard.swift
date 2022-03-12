//
//  KeyBoard.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 17/12/21.
//

import Foundation
import SwiftUI

struct KeyBoard :ViewModifier{
    
    @State var offset : CGFloat = 0
    
    func body(content: Content) -> some View {
        if #available(iOS 14.0, *) {
            content.padding(.bottom,offset)
                .animation(.none)
                .ignoresSafeArea(.keyboard, edges: .bottom)
                .onAppear {
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
                        let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                        let height = value.height
                        self.offset = height
                    }
                    
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in
                        
                        self.offset = 0
                    }
                }
        } else {
            // Fallback on earlier versions
            
            content.padding(.bottom,offset)
                .animation(.none)
                .onAppear {
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
                        let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                        let height = value.height
                        self.offset = height
                    }
                    
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in
                        
                        self.offset = 0
                    }
                }

        }
    }
}
