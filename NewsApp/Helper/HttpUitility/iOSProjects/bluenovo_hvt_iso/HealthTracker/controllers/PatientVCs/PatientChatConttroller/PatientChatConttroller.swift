//
//  PatientChatConttroller.swift
//  HealthTracker
//
//  Created by Apple on 28/10/21.
//

import Foundation
import UIKit
import MessageKit

class PatientChatConttroller: ChatViewController {
    
    init(user : SenderType){
        super.init(nibName: nil, bundle: nil)
        self.currentUser = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
