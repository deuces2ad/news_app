//
//  CustomHalfSheet.swift
//  Rocket_iOS
//
//  Created by Apple on 20/01/22.
//

import SwiftUI

enum SheetMode{
    case none
    case half
    case full
    case quarter
}

struct FlexibleSheet<Content : View> : View {
    
    let content : () -> Content
    var sheetMode : Binding<SheetMode>
    
    init(sheetMode : Binding<SheetMode> , @ViewBuilder content : @escaping () -> Content){
        self.content = content
        self.sheetMode = sheetMode
    }
    
    private func calculateOffset() -> CGFloat{
        
        switch sheetMode.wrappedValue {
            
        case .none:
            return getRect().height
            
        case .half:
            return  UIDevice.isIPad ? 700  : UIDevice.hasNotch ?  getRect().height / 2 : 260
            
        case .full:
            return 0
            
        case .quarter:
            return getRect().height - 200
        }
        
    }
    
    var body: some View{
        
        content()
            .offset(y: calculateOffset())
            .animation(.spring())
            .frame(maxWidth:.infinity)
            .edgesIgnoringSafeArea(.all)
        
    }
}

