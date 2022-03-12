//
//  MyPortfolioDetailView.swift
//  Rocket_iOS
//
//  Created by Apple on 04/01/22.
//

import SwiftUI

struct MyPortfolioDetailView: View {
    
     // MARK: - PROPERTIES
    
    let TAG = "MyPortfolioDetailView"
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showProductTransfer: Bool = false
    var bottomContainerSize : CGFloat{
        return UIDevice.hasNotch ? 100 : 60
    }
    
    
     // MARK: - BODY
    
    var body: some View {
        ZStack{
            VStack{
                //Nav bar...
                HStack {
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("back")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.black)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 15,alignment: .leading)
                            .padding(.vertical)
                    }//Button
                    
                    Spacer()
                    
                    Text("Detail")
                        .foregroundColor(.black)
                        .font(Font.custom(AppThemeConfig.AvenirFont, size: 20))
                    
                    Spacer()
                }//HSTACK
                
                // portfolio dream info view.....
                MyPortfolioDreamItem(showSellAndTopUpButton: false)
                
                
                VStack(spacing: 20){
                    //heading.....
                    Text("Detail Investment")
                        .foregroundColor(AppThemeConfig.themeLightBrownColor)
                        .font(Font.custom(AppThemeConfig.AvenirFont, size: 18))
                        .frame(maxWidth:.infinity,alignment:.leading)
                    
                    VStack(spacing:10) {
                        DeatailedInvestmentInfo(title: "Price", value: "4343")
                        DeatailedInvestmentInfo(title: "Intial Capital", value: "4343")
                        DeatailedInvestmentInfo(title: "Yeild", value: "4343")
                        DeatailedInvestmentInfo(title: "Purchase Price", value: "4343")
                        DeatailedInvestmentInfo(title: "Total Unit", value: "4343")
                    }
                }
                .padding()
                NavigationLink(destination: TransaferDreamView()) {
                    Text("Move your product")
                        .foregroundColor(AppThemeConfig.orangeColor)
                }
                Spacer()
                
            }
            .padding(.horizontal,15)
            .modifier(HideNavigationBar())
            
            
            VStack{
                Spacer()
                Rectangle()
                .foregroundColor(.white)
                .frame(height:bottomContainerSize)
                .frame(maxWidth:.infinity,alignment: .bottomLeading)
                .shadow(color: .black.opacity(0.3), radius: 6, x: 2, y: 2)
                .overlay(
                    
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
                        .padding()
                )
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        
    }
}

struct MyPortfolioDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MyPortfolioDetailView()
            .previewDevice(DeviceList.iPhone8)
        MyPortfolioDetailView()
            .previewDevice(DeviceList.iPhone13)
    }
}




struct DeatailedInvestmentInfo: View {
    
    var title : String
    var value : String
    
    var body: some View {
        HStack{
            Text(title)
            
                .foregroundColor(AppThemeConfig.themeGrayColor)
            Spacer()
            Text(value)
        }
    }
}
