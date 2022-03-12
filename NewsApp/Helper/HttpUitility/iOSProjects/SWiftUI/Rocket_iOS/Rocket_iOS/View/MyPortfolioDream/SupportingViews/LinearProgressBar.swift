//
//  LinearProgressBar.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 04/01/22.
//

import SwiftUI

struct LinearProgressBar: View {
    
     // MARK: - PROPERTIES
    
    @Binding var percentage: CGFloat
    
    // MARK: - BODY
    
    var body: some View {
        
        ZStack(alignment: .leading){
            
            ZStack{
                RoundedRectangle(cornerRadius: 5)
                    .fill(.white)
                    .frame(width: getRect().width - 50, height: 20)
            }
            
           RoundedRectangle(cornerRadius: 5)
                .fill(AppThemeConfig.orangeColor)
                .frame(width: self.getPercentageCall(), height: 20)
            
            Text(String(format: "%.0f", self.percentage * 100) + "%")
                .foregroundColor(self.percentage * 100 > 5 ? .white : AppThemeConfig.orangeColor)
                .font(Font.custom(AppThemeConfig.AvenirFont, size: 14))
                .padding(.leading,self.percentage * 100 > 5 ? 4 : 16)
                .background(Color.clear)
        }
    }
    
    func getPercentageCall() -> CGFloat{
        
        let width = getRect().width - 50
        return width * self.percentage
    }
}

struct LinearProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        LinearProgressBar(percentage: .constant(0.06))
            .padding()
            .previewLayout(.sizeThatFits)
            .background(AppThemeConfig.themeLightYellowColor)
           
          
    }
}
