//
//  MyPortfolioListView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 03/01/22.
//

import SwiftUI

struct MyPortfolioListView: View {
    
     // MARK: - PROPERTIES
    
    let TAG = "MyPortfolioListView"
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showProductDeatiledView : Bool = false
    
    var containerSize : CGFloat {
        return UIDevice.isIPad ? 0.30
        :
        UIDevice.hasNotch ? 0.25 : 0.30
    }
    
    
    // MARK: - BODY
    
    var body: some View{
        
        VStack{
            Image("homeBg")
                .resizable()
                .frame(width: getRect().width, height: getRect().height * containerSize)
                .aspectRatio(contentMode: .fit)
                .background(AppThemeConfig.themeLightYellowColor)
                .edgesIgnoringSafeArea(.top)
                .overlay(
                    
                    VStack(alignment: .leading, spacing: 0){
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
                            
                            Text("My Portfolio")
                                .foregroundColor(.black)
                                .font(Font.custom(AppThemeConfig.AvenirFont, size: 20))
                            
                        }//HSTACK
                        
                        VStack(spacing:10){
                            PortfolioInfoView()
                            YieldInfoView()
                           
                        }
                    
                     
                    }
                        .padding(.horizontal,15)
                        .frame(maxHeight:.infinity,alignment: .topLeading)
                )
            
            ScrollView(.vertical,showsIndicators: false){

                VStack(alignment: .leading, spacing: 10){
                    PortfolioDreamCardView(screenSize: getRect().size, dreamName: "Home Renvo", amount: 1000)
                        .onTapGesture {
                            showProductDeatiledView = true
                        }
                    
                }
                .padding(25)

            }
            .frame(maxWidth:.infinity,maxHeight: .infinity)
                .background(
                    Color.white
                        .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
                )

            NavigationLink(destination: MyPortfolioDreamView()) {
                Text("Create a New Dream")
                    .padding(.vertical,12)
                    .frame(maxWidth:.infinity)
                    .modifier(CustomButtonStyle(forgroundColor: AppThemeConfig.themeYellowColor))
            }
//            .background(Color.white)
            .padding(.bottom)
            .padding(.horizontal,25)
            
        }
        .modifier(HideNavigationBar())
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(AppThemeConfig.themeLightYellowColor)
    }
    
}
 // MARK: - PREVIEW

struct MyPortfolioListView_Previews: PreviewProvider {
    static var previews: some View {
        MyPortfolioListView()
            .previewDevice(DeviceList.iPhone8)
        MyPortfolioListView()
            .previewDevice(DeviceList.iPhone13)
        MyPortfolioListView()
            .previewDevice(DeviceList.iPadMini6ThGeneration)
    }
    
}
