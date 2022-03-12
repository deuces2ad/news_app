//
//  Intro.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 29/12/21.
//

import SwiftUI

// Intro Model And Sample Intro's...
struct Intro: Identifiable{
    var id = UUID().uuidString
    var image: String
    var title: String
    var description: String
    var color: Color
}

var intros : [Intro] = [

    Intro(image: "1", title: "Choose your favourite menu", description: "Rocket siap berangkat dan bawa kamu belajar investasi reksadana!",color: Color.white),
    
    Intro(image: "2", title: "Find the best price", description: "Mimpi terus... nyampenya kapan nih? Nebeng Rocket aja!",color: AppThemeConfig.orangeColor),
    
    Intro(image: "3", title: "Your food is ready to be delivered", description: "Cari uang tambahan\n dengan cara yang asik!\nLuncurkan Rocketmu sekarang!",color: Color.white),
    
]
