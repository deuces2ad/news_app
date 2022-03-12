//
//  CreateNewGoalView.swift
//  Rocket_iOS
//
//  Created by Apple on 18/01/22.
//

import SwiftUI

struct CreateNewGoalView: View {
    
 
    @State var preSelected : String = "dream_home"
    let dreamsImages : [String] = ["moneyInHand","dream_home","beach","wedding","blood_donation","baby_on_floor"]
    
    var columns = 2
    
    var fontSize : CGFloat {
        return UIDevice.isIPad ? 21 : 16
    }
    
    var body: some View {
        
        VStack {
            NavigationBar(title: .constant("Dreams Come True"))
                .padding(.bottom)
            
           Text("Want to save up for a new car, house, or trying to start a business? Everyone can be with Rocket!")
            
                .multilineTextAlignment(.center)
                .font(Font.custom(AppThemeConfig.AvenirFont, size: fontSize))
            
            
            ScrollView{
                UIGrid(columns: columns, list: dreamsImages) { emoji in
                    
                   DreamItemView(selectedImage: preSelected, itemImage: emoji)
                        .onTapGesture {
                            preSelected = emoji
                        }
                    
                }
            }
            
            Button(action: {}) {
                Text("Create Your Own Dreams")
                    .font(Font.custom(AppThemeConfig.AvenirFont, size: 18).weight(.bold))
                    .foregroundColor(AppThemeConfig.orangeColor)
            }
            
            
            NavigationLink(destination: SetGoalAmountView().environmentObject(NumpadGlobalObject())) {
                Text("Start")
                    .padding(.vertical,10)
                    .frame(width: 200)
                    .modifier(CustomButtonStyle(forgroundColor: AppThemeConfig.themeYellowColor))
            }

        }
        .padding([.horizontal,.bottom])
        .modifier(HideNavigationBar())
    }
}

struct CreateNewGoalView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group{
            
            CreateNewGoalView()
                .previewDevice(DeviceList.iPhone8)
            
            CreateNewGoalView()
                .previewDevice(DeviceList.iPhone13)
            
            CreateNewGoalView()
                .previewDevice(DeviceList.iPadMini6ThGeneration)
            
        }
       
    }
}



struct NavigationBar: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var title : String
    
    var body: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
                
            }) {
                Image("back")
                    .resizable()
                    .frame(width: 10, height: 15)
                    .aspectRatio(contentMode: .fit)
                    .padding(.vertical)
            }//Button
            
            
            Text(title)
                .foregroundColor(.black)
                .font(Font.custom(AppThemeConfig.AvenirFont, size: 20))
            
            Spacer()
            
        }
    }
}
