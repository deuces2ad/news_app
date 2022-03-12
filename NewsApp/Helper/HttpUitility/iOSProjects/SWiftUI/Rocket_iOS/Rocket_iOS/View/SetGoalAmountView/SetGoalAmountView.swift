//
//  SetGoalAmountView.swift
//  Rocket_iOS
//
//  Created by Apple on 19/01/22.
//

import SwiftUI

struct SetGoalAmountView: View {
    
     // MARK: - PROPERTIES
    
    @EnvironmentObject var env : NumpadGlobalObject
    
    var fontSize : CGFloat {
        return UIDevice.isIPad ? 21 : 16
    }
    
    @State var isNavigationAllowed : Bool = false
    
    var isLinkActive : Bool{
        return env.display.count > 1 ? true : false
    }
    
     // MARK: - BODY
    
    var body: some View {
        
        VStack {
            NavigationBar(title: .constant("Dreams Come True"))
            
           Text("Want to save up for a new car, house, or trying to start a business? Everyone can be with Rocket!")
            
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .font(Font.custom(AppThemeConfig.AvenirFont, size: fontSize))
           
            VStack(spacing:15){
                
                Text(CurrencyFormatter.convertToIDRFormat(with: env.display))
                    .font(.custom(AppThemeConfig.AvenirFont, size: 30))
                
                RoundedRectangle(cornerRadius: 6)
                    .foregroundColor(AppThemeConfig.orangeColor)
                    .frame(width:getRect().width * 0.70 ,height:2)
                
            }
            .padding([.vertical])
            
            Spacer()
            NumpadView()
            Spacer()

            Button(action: {
                if env.display.count > 1{
                    isNavigationAllowed = true
                }else{
                    isNavigationAllowed = false
                }
            }) {
                Text("Start")
                    .padding(.vertical,10)
                    .frame(width: getRect().width * 0.70)
                    .modifier(CustomButtonStyle(
                        forgroundColor: isLinkActive ? AppThemeConfig.themeYellowColor : AppThemeConfig.LightGray ,
                        textColor:isLinkActive ? AppThemeConfig.themeLightBrownColor : .black.opacity(0.5) ))
            }
            .disabled(!isLinkActive)
            .padding(.bottom)
            
            NavigationLink(destination: GoalInvestmentView(),isActive: $isNavigationAllowed) {Text("")}


        }.frame(maxHeight:.infinity,alignment: .top)
        .padding([.horizontal,.bottom])
        .modifier(HideNavigationBar())
    }
}

 // MARK: - PREVIEW

struct SetGoalAmountView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            SetGoalAmountView()
                .previewDevice(DeviceList.iPhone8)
            SetGoalAmountView()
                .previewDevice(DeviceList.iPhone13)
            SetGoalAmountView()
                .previewDevice(DeviceList.iPadMini6ThGeneration)
        }
       
            .environmentObject(NumpadGlobalObject())
    }
}
