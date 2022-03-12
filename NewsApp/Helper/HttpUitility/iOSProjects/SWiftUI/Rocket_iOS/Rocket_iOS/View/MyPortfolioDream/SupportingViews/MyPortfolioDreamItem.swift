//
//  MyPortfolioDreamItem.swift
//  Rocket_iOS
//
//  Created by Apple on 04/01/22.
//

import SwiftUI

struct MyPortfolioDreamItem: View {
    
     // MARK: - PROPERTIES
    let TAG = "MyPortfolioDreamItem"
    @State private var profit : CGFloat = 2.40
    @State private var unitPrice : CGFloat = 1.94438
    @State private var managedFunds : CGFloat  = 1
    var showSellAndTopUpButton : Bool = true
    
    
     // MARK: - BODY
    
    var body: some View {
        
            VStack(alignment: .leading,spacing: 20){
                // top section...
                HStack{
                    Rectangle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(AppThemeConfig.themeLightYellowColor)
                        .cornerRadius(6)
                    
                    Text("Aberdeen Standard Indonesia Equity Fund")
                        .foregroundColor(.black)
                        .font(Font.custom(AppThemeConfig.AvenirFont, size: 16))
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal,20)
                    
                }
                .frame(maxWidth:.infinity,alignment: .leading)
                
                // Middle section...
                
                HStack{
                    
                    VStack(alignment:.leading,spacing:8){
                        Text("Profit")
                        HStack{
                            Image("arrowtriangle.up.fill")
                            Text(String(self.formatedPercentage()))
                        }
                        
                    }
                    Spacer()
                    
                    VStack(alignment:.leading,spacing:8){
                        Text("Unit Price")
                        Text(String(self.formatedUnitPrice()))
                    }
                    
                    Spacer()
                    
                    VStack(alignment:.leading,spacing:8){
                        Text("Manage Funds")
                        Text(String(self.formatedManegedFunds()))
                        
                    }
                    
                }
                
                //sell and topup button...
                if showSellAndTopUpButton{
                    
                    HStack{
                        Button(action: {
                            
                        }) {
                            Text("Sell")
                                .padding(.vertical,10)
                                .frame(maxWidth:.infinity)
                                .modifier(CustomButtonStyle(forgroundColor: .white))
                                .modifier(CustomStroke(borderColor: AppThemeConfig.themeYellowColor, lineWidth: 1.5))
                               
                        }
                        
                        Button(action: {
                            
                        }) {
                            Text("Top up")
                                .padding(.vertical,10)
                                .frame(maxWidth:.infinity)
                                .modifier(CustomButtonStyle(forgroundColor: AppThemeConfig.themeYellowColor))
                               
                        }
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
        .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 2)
    }
    
    //helper functions...
    func formatedPercentage()->String{
        return "\(profit) %"
    }
    
    func formatedUnitPrice()->String {
        return "Rp " + "\(unitPrice)"
    }
    
    func formatedManegedFunds()->String {
        return "Rp " + "\(managedFunds)M"
    }
    
}

struct MyPortfolioDreamItem_Previews: PreviewProvider {
    static var previews: some View {
        MyPortfolioDreamItem()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
