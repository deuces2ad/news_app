//
//  DreamItemView.swift
//  Rocket_iOS
//
//  Created by Apple on 18/01/22.
//

import SwiftUI

struct DreamItemView: View {
    
    var selectedImage : String
    var itemImage : String
  
    
    private var lineWidth : CGFloat?{
        return selectedImage == itemImage ? 2 : 0
    }
    private var itemSize : CGFloat{
        return UIDevice.isIPad ? 250 : 120
    }
    
    var body: some View {
        
        ZStack{
            Image(itemImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: itemSize, height: itemSize, alignment: .center)
                .background(selectedImage == itemImage ? .white : AppThemeConfig.LightGray )
                
        }
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(AppThemeConfig.themeYellowColor,lineWidth: lineWidth ?? 2.5)
        )
        .cornerRadius(6)
    }
}

struct DreamItemView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        DreamItemView(selectedImage: "baby_on_floor", itemImage: "baby_on_floor")
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
