//
//  TokenRewardsDistribution.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 23/12/21.
//

import SwiftUI

struct TokenRewardsInfo :Identifiable {
    var id = UUID()
    let discription : String
    let tokenRewardsStatus : TokenRewardStatus
    let numberOfToken : Int
}

struct myHashableProctcol :Identifiable{
    var id = UUID()
    
    
}

struct TokenRewardsDistribution: View {
    
     // MARK: - PROPERTIES
    
    var screenSize : CGSize
    
    var   tokenRewardsDiscrptionTxts : [TokenRewardsInfo] = [ TokenRewardsInfo(discription: "Lengkapi Identitasmu",                                                                   tokenRewardsStatus: .claim, numberOfToken: 3),
                                                              TokenRewardsInfo(discription: "Verifikasi Email", tokenRewardsStatus: .claim, numberOfToken: 2),
                                                              TokenRewardsInfo(discription: "KYC", tokenRewardsStatus: .go, numberOfToken: 4),
                                                              TokenRewardsInfo(discription: "Bangun Impian", tokenRewardsStatus: .claimed, numberOfToken: 10)]
    
    // MARK: - BODY
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 25) {
            Text("How To Get Tokens")
                .font(Font.custom(AppThemeConfig.AvenirFont, size: 21))
                .foregroundColor(AppThemeConfig.themeLightBrownColor)
                .frame(maxWidth:.infinity,alignment: .leading)

            VStack{
                ForEach(tokenRewardsDiscrptionTxts ){ item in
                    TokenRewardsItemView(numberOfToken: item.numberOfToken, text: item.discription, tokenRewardStatus: item.tokenRewardsStatus, screenSize: screenSize)
                }
            }
        }
//        .padding(.horizontal,20)
    }
}

struct TokenRewardsDistribution_Previews: PreviewProvider {
    static var previews: some View {
        TokenRewardsDistribution(screenSize: UIScreen.main.bounds.size)
    }
}
