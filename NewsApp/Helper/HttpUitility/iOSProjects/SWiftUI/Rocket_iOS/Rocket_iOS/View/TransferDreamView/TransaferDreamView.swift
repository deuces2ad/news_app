//
//  TransaferDreamView.swift
//  Rocket_iOS
//
//  Created by Apple on 05/01/22.
//

import SwiftUI

struct TransaferDreamView: View {
    
     // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
     // MARK: - BODY
    
    var body: some View {
        VStack{
            //Nav bar...
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
                
                Spacer()
                
                Text("Product Transfer")
                    .foregroundColor(.black)
                    .font(Font.custom(AppThemeConfig.AvenirFont, size: 20))
                
                Spacer()
            }//HSTACK
           
            
            ScrollView{
                
            
                    let size = getRect().size
                    
                    VStack{
                        Text("You will move the product")
                            .modifier(LightGrayTitle())
                        
                        MyPortfolioDreamItem(showSellAndTopUpButton: false)
                            .padding(.horizontal,2)
                        
                        Text("Product Details")
                            .modifier(LightGrayTitle())
                        
                        VStack(spacing:20){
                            DeatailedInvestmentInfo(title: "Unit Price", value: "43434")
                                .modifier(RectangularFrame())
                            
                            DeatailedInvestmentInfo(title: "Unit Price", value: "43434")
                                .modifier(RectangularFrame())
                            
                            CustomProgressSliderView(screenSize: size)
                            
                        }
                       
                    }
                    .frame(maxWidth:.infinity)
                    
                    
            }

        }
        .padding(.horizontal,15)
        .modifier(HideNavigationBar())
    }
}

struct TransaferDreamView_Previews: PreviewProvider {
    static var previews: some View {
        TransaferDreamView()
            .previewDevice(DeviceList.iPhone8)
        TransaferDreamView()
            .previewDevice(DeviceList.iPhone13)
    }
}


 // MARK: - TItle Modifier



