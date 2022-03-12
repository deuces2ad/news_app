//
//  SubView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 29/12/21.
//

import SwiftUI

struct SubView: View {
    
    var screenSize: CGSize
    @State var offset: CGFloat = 0
    @State private var showLogin = false
    
    var body: some View {
        
        ZStack {

            VStack{
               
                OffsetPageTabView(offset: $offset) {
                
                    HStack(spacing: 0){
                        
                        ForEach(intros){ intro in
                            VStack(alignment: .leading, spacing: 0){
                                ItemView(imageName: intro.image, discription: intro.description,bGcolor: intro.color)
                            }
                            .frame(width:screenSize.width)
                        }
                     
                        
                    }
                    .edgesIgnoringSafeArea(.all)
                }
                
                .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .leading)

            }
            .edgesIgnoringSafeArea(.all)
            // Animated Indicator....
            ZStack(alignment: .bottom) {
                HStack(alignment: .bottom) {
                    
                    // Indicators...
                    HStack(spacing: 12){
                        
                        ForEach(intros.indices,id: \.self){index in

//                            Capsule()
//                                .fill(.white)
//                            // increasing width for only current index...
//                                .frame(width: getIndex() == index ? 20 : 7, height: 7)

                            if getIndex() == 1{
                                Capsule()
                                        .frame(width: getIndex() == index ? 45 : 7, height: 7)

                                        .foregroundColor(getIndex() == index ? Color.white : Color.init(hex: "FFCE08"))
                            }else{
                                Capsule()
                                        .frame(width: getIndex() == index ? 45 : 7, height: 7)
                                        .foregroundColor(getIndex() != (index) ? Color.init(hex:"C4C4C4") : AppThemeConfig.orangeColor)
                            }
                        }
                        
                        
                    }
                    
                    .overlay(
                    
                    
                        Capsule()
                            .fill(getIndex() == 1 ? .white : AppThemeConfig.orangeColor)
                            .frame(width: 45, height: 7)
                            .offset(x: getIndicatorOffset())
                        
                        ,alignment: .leading
                        
                    )
                    .offset(x: 10, y: -15)
                    
                    Spacer()
                    
                    if getIndex() != 2{
                        NextPageAction{
                            // updating offset...
                            let index = min(getIndex() + 1, intros.count - 1)
                            offset = CGFloat(index) * screenSize.width
                        }
                        .offset(x: 10, y: -10)
                    }else{
                        CarryOnBtnAction{
                            withAnimation {
                                showLogin = true
                            }

                        }
                        .offset(x: 10, y: -10)
                    }

                }
              
                .padding()
            .offset(y: -20)
            }
//            .background(Color.blue)
            .frame(maxHeight:.infinity,alignment: .bottom)
            
            // Animating when index Changes...
        .animation(.easeInOut,value: getIndex())
            
        }
        .overlay (
            Group{
                if showLogin{
                    LoginView()
                        .transition(.move(edge: .bottom))
                }
            }
        )
        
    }
    
    // offset for indicator...
    func getIndicatorOffset()->CGFloat{
        
        let progress = offset / screenSize.width
        
        // 12 = spacing
        // 7 = Circle size...
        
        let maxWidth: CGFloat = 12 + 7
        
        return progress * maxWidth
    }
    
    // Expading index based on offset...
    func getIndex()->Int{
        
        let progress = round(offset / screenSize.width)
        
        // For Saftey...
        let index = min(Int(progress), intros.count - 1)
        return index
    }
}


    


struct SubView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
            .previewDevice(DeviceList.iPadMini6ThGeneration)
        
    }
}
