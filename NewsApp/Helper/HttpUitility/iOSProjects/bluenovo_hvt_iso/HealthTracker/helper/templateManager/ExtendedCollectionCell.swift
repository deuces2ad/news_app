//
//  ExtendedCollectionCell.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 28/07/21.
//

import Foundation
import  UIKit

class ExtendedCollectionCell: UICollectionViewCell {

     var isLoaded = false
    override func awakeFromNib() {
        super.awakeFromNib()
        //Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
        if(!isLoaded){
            isLoaded = true
            viewDidLayout()
        }
    }
    
    func viewDidLayout(){
    }
}

