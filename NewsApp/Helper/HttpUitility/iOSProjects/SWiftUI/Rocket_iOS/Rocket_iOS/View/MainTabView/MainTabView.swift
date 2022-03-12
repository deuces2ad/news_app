//
//  MainTabView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 21/12/21.
//

import SwiftUI

struct MainTabView: View {
   
     // MARK: - PROPERTIES
    
    @State var selectedTab : String = "Home"

     // MARK: - BODY
    
    var body: some View {
        
        VStack(spacing:0){

            ZStack(alignment: .center){
                
                GeometryReader{ geometry in

                    VStack{
                        
                        switch selectedTab{

                        case "Home":
                            HomeView()
                        case "Rocket":
                            RocketView()
                        case "Product":
                            ProductView()
                        case "Help":
                            HelpView()
                        case "Profile":
                            ProfileView()

                        default:
                            EmptyView()
                        }
                    }

//                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
//                    .backport.topPadding(44)
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("") //this must be empty
             .navigationBarHidden(true)
             .navigationBarBackButtonHidden(true)
            Divider()
            HStack(alignment: VerticalAlignment.bottom,spacing:0){

                ForEach(tabItems){ item in
                    TabButtonView(tabItem: item, selectedTab: $selectedTab)

                    if item != tabItems.last{

                        Spacer(minLength: 0)
                    }
                }
            }//HSTACK

            .padding(.horizontal,25)
            .padding(.top,10)
            .background(Color.white)
        }

    }
}



struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .previewDevice(DeviceList.iPadMini6ThGeneration)
    }
}

var tabImages = ["Home","rocket","product","help","profile"]

var tabItems : [TabItemInfo] = [
    TabItemInfo(name: "Home", image: "home", unselectedImage: "us_home"),
    TabItemInfo(name: "Rocket", image: "rocket", unselectedImage: "us_rocket"),
    TabItemInfo(name: "Product", image: "product", unselectedImage: "us_product"),
    TabItemInfo(name: "Help", image: "help", unselectedImage: "us_help"),
    TabItemInfo(name: "Profile", image: "profile", unselectedImage: "us_profile")
]

struct TabItemInfo : Identifiable, Equatable{
    var id = UUID()
    var name: String
    var image: String
    var unselectedImage : String
}


