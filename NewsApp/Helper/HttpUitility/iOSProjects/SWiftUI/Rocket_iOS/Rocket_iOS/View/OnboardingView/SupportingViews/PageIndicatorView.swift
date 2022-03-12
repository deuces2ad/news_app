//
//  PageIndicatorView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 16/12/21.
//

import SwiftUI

struct PageIndicatorView: View {
    
    @Binding var currentPageIndex : CGFloat
    
    var body: some View {
        
        HStack {
            ForEach(0..<3){ index in
                if currentPageIndex == 1{
                    Capsule()
                            .frame(width: currentPageIndex == CGFloat(index) ? 45 : 10,
                                   height: 10)
                            
                            .foregroundColor(currentPageIndex == CGFloat(index) ? Color.white : Color.init(hex: "FFCE08"))
                }else{
                    Capsule()
                            .frame(width: currentPageIndex == CGFloat(index) ? 45 : 10,
                                   height: 10)
                            .foregroundColor(currentPageIndex != CGFloat(index) ? Color.init(hex: "C4C4C4") : AppThemeConfig.orangeColor)
                }
           
            }
        }
    }
    func getOffset()->CGFloat{
        let progress = currentPageIndex / getRect().width
        return 22 * progress
    }
}

struct PageIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        PageIndicatorView(currentPageIndex: .constant(1))
            .previewLayout(.sizeThatFits)
    }
}
