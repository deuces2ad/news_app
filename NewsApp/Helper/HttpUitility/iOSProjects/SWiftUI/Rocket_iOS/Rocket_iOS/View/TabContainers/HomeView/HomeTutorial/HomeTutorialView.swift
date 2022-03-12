//
//  HomeTutorialView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 23/12/21.
//

import SwiftUI

struct HomeTutorialView: View {
    
    
     // MARK: - PROPERTIES
    
    @Binding var scrollPostionId : Int
    

    
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    
    var body: some View {
        
        
        GeometryReader { proxy in
            let size = proxy.size
            VStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 100, height: 60)
                    .foregroundColor(.white)
                    .overlay(
                        ZStack{
                            HStack {
                                RocketInsideCircularStroke()
                                Text("0")
//                                    .padding()
                            }
                        }
                    )
                    .frame(maxWidth:.infinity,alignment: .trailing)
//                    .padding()



                Image("Arrow")
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth:.infinity,alignment: .trailing)
                    .padding(.trailing,130)
                    .offset(y:-40)
                
                
                Text("Token untuk meluncurkan\n permainan Rocket dan\n memperoleh reward")
                    .foregroundColor(AppThemeConfig.themeLightBrownColor)
                    .font(Font.custom(AppThemeConfig.AvenirFont, size: 18).bold())
                    .padding()
                    .background(
                        GeometryReader{ proxy in
                            let size = proxy.size
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width: size.width + 30, height: size.height + 3, alignment: .bottomTrailing)
                                .foregroundColor(.white)
                        }
                    )
                    .offset(y:-30)
                    .fixedSize()
                    .frame(maxWidth:.infinity,alignment: .trailing)
                    .padding(.trailing,40)

                
                Spacer()
                
                Button(action: {
                   scrollPostionId = 2
                    self.viewControllerHolder?.dismiss(animated: true, completion: nil)
                }) {
                    Text("Skip")
                        .font(Font.custom(AppThemeConfig.AvenirFont, size: 18))
                        .foregroundColor(.white)
                        .padding()
                }
                .frame(maxWidth:.infinity,alignment: .leading)
                .padding()
                
            }
            .frame(width: size.width, height: size.height, alignment: .center)
        }
    }
}

//@available(iOS 15.0, *)
struct HomeTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            HomeTutorialView(scrollPostionId: .constant(2))
                .previewDevice("iPhone 8")
                .background(Color.red)
            HomeTutorialView(scrollPostionId: .constant(2))
                .background(Color.red)
                .previewDevice("iPhone 13")
            HomeTutorialView(scrollPostionId: .constant(2))
                .background(Color.red)
                .previewDevice("iPad mini(6th genration")
        }
    }
}
