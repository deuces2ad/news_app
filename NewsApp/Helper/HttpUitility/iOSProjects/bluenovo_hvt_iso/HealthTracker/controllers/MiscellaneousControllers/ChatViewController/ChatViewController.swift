//
//  ChatViewController.swift
//  HealthTracker
//
//  Created by Apple on 28/10/21.
//

import Foundation
import UIKit
import MessageKit

class ChatViewController :MessagesViewController{
    
    var currentUser : SenderType?
    var otherUser : SenderType?
    
    var messages = [MessageType]()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }
    // MARK: - Initialization
    
    func initialization(){
        setupMessageKitDelegate()
        loadMessages()
    }
    
    func loadMessages(){
        messages.append(Message(sender: currentUser!,
                                messageId: "1",
                                sentDate: Date(),
                                kind: .text("Hi Dr. Anna Maria")))
        
        messages.append(Message(sender: otherUser!,
                                messageId: "2",
                                sentDate: Date(),
                                kind: .text("Hi Aditi")))
        
        messages.append(Message(sender: currentUser!,
                                messageId: "3",
                                sentDate: Date(),
                                kind: .text("Are we up for meeting?")))
        
        messages.append(Message(sender: otherUser!,
                                messageId: "4",
                                sentDate: Date(),
                                kind: .text("Yes, we are!")))
    }
    
    // MARK: - Delegate Method
    func setupMessageKitDelegate(){
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
    
    
    
}

extension ChatViewController : MessagesLayoutDelegate,MessagesDataSource,MessagesDisplayDelegate{
    func currentSender() -> SenderType {
        return currentUser!
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }

}

// MARK: - Sender Info
struct Sender : SenderType{
    var senderId: String
    var displayName: String
}
// MARK: - Message Info
struct Message : MessageType{
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}
