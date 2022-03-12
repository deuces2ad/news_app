//
//  PortfolioDreamCardView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 03/01/22.
//

import SwiftUI

struct PortfolioDreamCardView: View {
    
    let TAG = "PortfolioDreamCardView"
    var screenSize : CGSize
    var dreamName : String
    var amount: Double
    
    
    var body: some View {
        
        let formatedDreamAmount = "Rp " + "\(amount)"
        
        ZStack {
            VStack(alignment: .leading){
                
                HStack {
                    VStack(spacing: 10){
                        Text(dreamName)
                            .frame(maxWidth:.infinity,alignment: .leading)
                            .font(Font.custom(AppThemeConfig.AvenirFont, size: 16))
                        
                        Text(formatedDreamAmount)
                            .frame(maxWidth:.infinity,alignment: .leading)
                            .font(Font.custom(AppThemeConfig.AvenirHeavy, size: 18))
                
                    }
                    
                    CircularProgressBar(screenSize: screenSize)
                      
                }
                
                YieldInfoView()
                
                HStack{
                

                    Button(action: {
                        Log.echo(key: TAG, text: "TOP UP tapped!")
                    }) {
                        Text("Top Up")
                            .frame(maxWidth:.infinity)
                            .padding(.vertical,8)
                            .modifier(CustomButtonStyle(forgroundColor: AppThemeConfig.themeYellowColor))
                           
                    }
                    
                    Button(action: {
                        Log.echo(key: TAG, text: "Sell tapped!")
                    }) {
                        Text("Sell")
                            .frame(maxWidth:.infinity)
                            .padding(.vertical,8)
                            .modifier(CustomButtonStyle(forgroundColor: .white))
                            .modifier(CustomStroke(borderColor: AppThemeConfig.themeYellowColor, lineWidth: 1.5))
                            
                    }
                    
                }
                .frame(maxWidth:.infinity)
                
                
            }
            .padding()
            .frame(height:screenSize.height * 0.32)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 2)
        }
        
        
    }
}

struct PortfolioDreamCardView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioDreamCardView(screenSize: UIScreen.main.bounds.size, dreamName: "Home Renvo", amount: 10000)
            .previewLayout(.fixed(width: UIScreen.main.bounds.size.width, height: 450))
            .padding()
    }
}
