//
//  TimelLineItemView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 30/12/21.
//

import SwiftUI


struct TimelLineItemView: View {
    
    let cells = [ CustomStepTextView(text: "Lengkapi Profil", timeInfo: ""),
                  CustomStepTextView(text: "Validasi Profil", timeInfo: "1 hari kerja"),
                  CustomStepTextView(text: "Verifikasi Akun", timeInfo: "5 hari kerja")
    ]
    
    let alignments = [StepperAlignment.center, .top, .center, .bottom]
    
    let indicators = [
        StepperIndicationType.custom(IndicatorImageView(name: "completed").eraseToAnyView()),
        StepperIndicationType.custom(IndicatorImageView(name: "completed").eraseToAnyView()),
        StepperIndicationType.custom(IndicatorImageView(name:"notCompleted").eraseToAnyView())
    ]
    
    var screenSize : CGSize
    
    var fontSize: CGFloat{
        return UIDevice.isIPad ? 21 : 16
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text("Proses Pendaftaran")
                .foregroundColor(AppThemeConfig.themeLightBrownColor)
                .font(Font.custom(AppThemeConfig.AvenirFont, size: fontSize))
                .frame(maxWidth:.infinity,alignment: .leading)
                .padding(.leading,30)
                .padding(.top)
            
            Text("Penjelasan deskriptif singkat")
                .foregroundColor(AppThemeConfig.themeLightBrownColor)
                .font(Font.custom(AppThemeConfig.AvenirFont, size: fontSize - 2))
                .frame(maxWidth:.infinity,alignment: .leading)
                .padding(.leading,30)
            
            HStack {
                StepperView()
                    .addSteps(self.cells)
                    .stepIndicatorMode(StepperMode.vertical)
                    .indicators(indicators)
                    .lineOptions(StepperLineOptions.custom(2, AppThemeConfig.themeYellowColor))
                    .spacing(20)
                    .lineOptions(StepperLineOptions.custom(6, AppThemeConfig.themeYellowColor))
            }
            
        }
   
    }
}

struct TimelLineItemView_Previews: PreviewProvider {
    static var previews: some View {
        TimelLineItemView(screenSize: UIScreen.main.bounds.size)
//            .previewLayout(.sizeThatFits)
    }
}
