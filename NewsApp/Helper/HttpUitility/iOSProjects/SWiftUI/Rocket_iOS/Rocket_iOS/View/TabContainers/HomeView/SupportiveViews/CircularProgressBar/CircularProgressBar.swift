//
//  CircularProgressBar.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 31/12/21.
//

import SwiftUI



struct CircularProgressBar: View {
    
    
     // MARK: - PROPERTIES
    
    var stat : Stats = Stats(currentData: 7.5, goal: 15)
    var screenSize: CGSize
    
    var barSize: CGFloat{
        return UIDevice.isIPad ? 0.18 : 0.28
    }
    
    
    // MARK: - BODY
    var body: some View {
        ZStack{
           
            
            Circle()
                .trim(from: 0, to:1)
                .stroke(AppThemeConfig.themeLightYellowColor, lineWidth: 8)
                .frame(width: (screenSize.width - 150) * barSize , height: (screenSize.width - 150) * barSize )
            
            Circle()
                .trim(from: 0, to: (stat.currentData / stat.goal))
            
                .stroke(AppThemeConfig.orangeColor, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .frame(width: (screenSize.width - 150)  * barSize , height: (screenSize.width - 150)  * barSize )
               
            
            Text(getPercent(current: stat.currentData, Goal: stat.goal) + " %")
                .font(Font.custom(AppThemeConfig.AvenirFont, size: 14))
//                .fontWeight(.bold)
                .foregroundColor(AppThemeConfig.themeLightBrownColor)
                .rotationEffect(.init(degrees: -90))
//                .background(Color.red)
                

        }
        .rotationEffect(.init(degrees: 90))
    }
}

struct CircularProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressBar(screenSize: UIScreen.main.bounds.size)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}



// calculating percent...

func getPercent(current : CGFloat,Goal : CGFloat)->String{
    
    let per = (current / Goal) * 100
    
    return String(format: "%.1f", per)
}

struct Stats : Identifiable {
    
    var id = UUID()
    var currentData : CGFloat
    var goal : CGFloat
}

 let stat_Data = Stats(currentData: 6.8, goal: 15)
