//
//  DoctorChatController.swift
//  HealthTracker
//
//  Created by Apple on 28/10/21.
//

import Foundation
import UIKit
import MessageKit

class DoctorChatController : ChatViewController{
    

    init(user : SenderType, otherUser : SenderType){
        super.init(nibName: nil, bundle: nil)
        self.currentUser = user
        self.otherUser = otherUser
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
