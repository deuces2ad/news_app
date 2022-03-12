//
//  TokenGatheringItemView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 23/12/21.
//

import SwiftUI

struct TokenRewardsItemView: View {
    
    // MARK: - PROPERTIES
    
    let TAG = "TokenRewardsItemView"
    var numberOfToken : Int
    var text : String
    var tokenRewardStatus : TokenRewardStatus
    var screenSize: CGSize
    
    // MARK: - BODY
    
    var body: some View {
        
        VStack {
                
                HStack(spacing: 5){
                    HStack{
                        RocketInsideCircularStroke()
                        Text("\(numberOfToken)")
                            .font(Font.custom(AppThemeConfig.AvenirFont, size: 18))
                            .foregroundColor(AppThemeConfig.themeLightBrownColor)
                    }
                    
                    Text(text)
                        .font(Font.custom(AppThemeConfig.AvenirFont, size: 15))
                        .fixedSize()
                        .padding([.trailing,],50)
                        .frame(maxWidth:.infinity,alignment: .leading)

                    
                    if tokenRewardStatus == .claimed{
                        
                        Capsule()
                            .frame(width: 50, height: 20)
                            .foregroundColor(AppThemeConfig.LightGray)
                            .overlay(
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color.black.opacity(0.4))
                                    .padding(.vertical,5)
                                    .frame(width: 30, height: 20)
                            )
    
                           
                        
                    }else{
                    
                        Button(action: {
                            tokenRwardsAction()
                        }) {
                            Text(tokenRewardStatus.rawValue)
                                .frame(width: 50, height: 20)
                                .font(.custom(AppThemeConfig.AvenirFont, size: 12).weight(.regular))
                                .foregroundColor(AppThemeConfig.themeLightBrownColor)
                                .background(AppThemeConfig.themeYellowColor)
                                .clipShape(Capsule())
                        }
                    }
                    
                    
                }
//            .padding(.vertical,16)
        }
    }
    
    func tokenRwardsAction(){
        
        switch tokenRewardStatus {
            
        case .go:
            Log.echo(key: TAG, text: "go")
            
        default:
            Log.echo(key: TAG, text: "Claim")
        }
    }
}

struct TokenGatheringItemView_Previews: PreviewProvider {
    static var previews: some View {
        TokenRewardsItemView(numberOfToken: 2, text: "cc",tokenRewardStatus: .claimed, screenSize: UIScreen.main.bounds.size)
            .previewLayout(.sizeThatFits)
            .padding()
        
        TokenRewardsItemView(numberOfToken: 2, text: "cc",tokenRewardStatus: .claim, screenSize: UIScreen.main.bounds.size)
            .previewLayout(.sizeThatFits)
            .padding()

    }
}

enum TokenRewardStatus : String  {
    case go = "Go"
    case claim = "Claim"
    case claimed = "Claimed"
}
