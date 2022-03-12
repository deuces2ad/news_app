//
//  BannersHorizontalGrid.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 23/12/21.
//

import SwiftUI


struct BannersHorizontalGrid: View {
    
    @ObservedObject var UIState: UIStateModel = UIStateModel()
    
    var body: some View {
        VStack(spacing:0){
            SnapCarousel(UIState: UIState )
                .frame(height: 150)
            
            HStack{
                ForEach(0..<4){ item in
                    
                    Capsule()
                        .frame(width: UIState.activeCard == item ? 30 : 10, height: 10)
                        .foregroundColor(UIState.activeCard == item ? AppThemeConfig.themeYellowColor : AppThemeConfig.LightGray)
                    
                    if item == 4{
                        Spacer()
                    }
                    
                }
            }
        }
    }
}

struct BannersHorizontalGrid_Previews: PreviewProvider {
    static var previews: some View {
        BannersHorizontalGrid()
            .previewLayout(.sizeThatFits)
    }
}
