//
//  DidMadeSelectionDelegate.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 19/09/21.
//

import Foundation

protocol  DidMadeSelectionDelegate : AnyObject {
    func didMadeSelection(type : CancellationReason)
}
