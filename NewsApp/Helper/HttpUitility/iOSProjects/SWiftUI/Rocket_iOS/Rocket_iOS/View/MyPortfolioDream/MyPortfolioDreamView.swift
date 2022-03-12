//
//  MyPortfolioDream.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 04/01/22.
//

import SwiftUI

struct MyPortfolioDreamView: View {
    
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var percentage : CGFloat = 0.80
    @State private var showMyPortfolioDeatilView : Bool = false
    
    var containerSize : CGFloat {
        return UIDevice.isIPad ? 0.30
        :
        UIDevice.hasNotch ? 0.35 : 0.40
    }
    
    
    var fontSize : CGFloat {
        return UIDevice.isIPad ? 28 : 21
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
////////                        //Nav bar...
                        //
//                        Spacer()
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

                            Text("Home Renovation")
                                .foregroundColor(.black)
                                .font(Font.custom(AppThemeConfig.AvenirFont, size: 20))

                            Spacer()

                            Button(action: {}) {
                                Image("pencil")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(.black)
                                    .frame(width: 20, height: 20, alignment: .center)
                            }

                        }//HSTACK
                        
                        VStack(alignment: .leading, spacing: 10){
                            PortfolioInfoView()
                            YieldInfoView()
                            LinearProgressBar(percentage: $percentage)
                                .padding(.vertical)


                        }


                    }
                        .padding(.horizontal,15)
                        .frame(maxHeight:.infinity,alignment: .topLeading)
                )
               
            ScrollView(.vertical,showsIndicators: false){

                VStack(alignment: .leading, spacing: 10){
                    MyPortfolioDreamItem()
                        .onTapGesture {
                            showMyPortfolioDeatilView = true
                        }
                    MyPortfolioDreamItem()

                }
                .padding(25)

            }
            .frame(maxWidth:.infinity,maxHeight: .infinity)
                .background(
                    Color.white
                        .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
                )
            NavigationLink(destination: MyPortfolioDetailView(), isActive: $showMyPortfolioDeatilView) {Text("")}


        }
                .backport.topPadding(30)
                .navigationBarTitle("") //this must be empty
                 .navigationBarHidden(true)
                 .navigationBarBackButtonHidden(true)
                .frame(maxWidth:.infinity,maxHeight: .infinity)
                .background(AppThemeConfig.themeLightYellowColor)
//                .edgesIgnoringSafeArea(.top)
    }
    
}

struct MyPortfolioDream_Previews: PreviewProvider {
    static var previews: some View {
        MyPortfolioDreamView()
            .previewDevice(DeviceList.iPhone8)
        MyPortfolioDreamView()
            .previewDevice(DeviceList.iPhone13)
        MyPortfolioDreamView()
            .previewDevice(DeviceList.iPadMini6ThGeneration)
        
        
    }
}
