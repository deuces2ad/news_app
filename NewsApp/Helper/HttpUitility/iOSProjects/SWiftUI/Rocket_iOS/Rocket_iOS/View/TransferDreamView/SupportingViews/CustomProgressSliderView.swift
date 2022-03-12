//
//  CustomProgressSliderView.swift
//  Rocket_iOS
//
//  Created by Apple on 05/01/22.
//

import SwiftUI

struct CustomProgressSliderView: View {
    
     // MARK: - PROPERTIES
    
    @State var percentage : CGFloat = 0
    var screenSize : CGSize
    

     // MARK: - BODY
    
    var body: some View {
        
        HStack(spacing:20) {
        
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 25, height: 25,alignment: .leading)
                .foregroundColor(AppThemeConfig.themeLightYellowColor)
                .overlay(
                    ZStack{
                        Text(getPrice())
                            .foregroundColor(AppThemeConfig.orangeColor)
                            .font(Font.custom(AppThemeConfig.AvenirFont, size: 13))
                        
                    }
                )
            
            
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.init(hex: "F7F7F7"))
                    .frame(height: 35)
                    .frame(width:screenSize.width - 80)
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(AppThemeConfig.themeYellowColor)
                    .frame(width: percentage,height: 35)
                
                
                Circle()
                    .fill(Color.white)
                    .frame(width: 25, height: 25)
                    .overlay(
                        ZStack{
                            HStack(spacing:5){
                                Image(systemName: "chevron.left")
                                    .resizable()
                                    .frame(width: 5, height: 8, alignment: .center)
                                
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .frame(width: 5, height: 8, alignment: .center)
                            }
                        }
                    )
                    .offset(x: percentage - 10)
                    .gesture(DragGesture().onChanged({ (value) in
                        
                        // Padding Horizontal....
                        
                        // Padding Horizontal = 30
                        // Circle radius = 20
                        // Total 50
                        if value.location.x > 10 && value.location.x <= screenSize.width - 75{
                            
                            // Circle Radius = 20
                            percentage = value.location.x - 10
                        }
                    }))
            })
                .background(RoundedRectangle(cornerRadius: 3).stroke(Color.white,lineWidth: 18)
                                .shadow(color: .black.opacity(0.3), radius: 2.5, x: 2, y: 2)
                )
        }


    }
    
    func getPrice()->String{
        
        let percent = (percentage / (screenSize.width - 85) * 100)
        return String(format: "%.f", percent)
    }
}

struct CustomProgressSliderView_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressSliderView(screenSize: UIScreen.main.bounds.size)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
