//
//  TabButtonView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 21/12/21.
//

import SwiftUI

struct TabButtonView: View {
    
     // MARK: - Properties
    var tabItem : TabItemInfo
    @Binding var selectedTab : String
    
    var body: some View {
        
        Button(action: {selectedTab = tabItem.name}) {
            VStack{
            
                Image( selectedTab == tabItem.name ? tabItem.image : tabItem.unselectedImage)
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 24, height: 24)
//                    .foregroundColor(selectedTab == tabItem.name ? AppThemeConfig.orangeColor : Color.black.opacity(0.4))

                
                Text(tabItem.name)
                    .font(Font.custom(AppThemeConfig.AvenirFont, size:12))
                    .multilineTextAlignment(.center)
                    .fixedSize()
                    .foregroundColor(Color.init(hex: "6E6E6E"))

            }
        }.navigationBarHidden(true)
    }
}

struct TabButtonView_Previews: PreviewProvider {
    static var previews: some View {
        let tabItem : TabItemInfo = TabItemInfo(name: "Home", image: "home", unselectedImage: "us_home")
        
        TabButtonView(tabItem: tabItem, selectedTab: .constant("Home"))
            .previewLayout(.sizeThatFits)
    }
}
