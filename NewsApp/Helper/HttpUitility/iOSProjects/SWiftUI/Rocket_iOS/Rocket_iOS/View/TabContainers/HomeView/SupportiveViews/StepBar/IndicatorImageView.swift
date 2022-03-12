//
//  IndicatorImageView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 30/12/21.
//

import SwiftUI

struct IndicatorImageView: View {
    var name:String
    var body: some View {
        ZStack {
            Image(name)
                .resizable()
                .frame(width: 25, height: 25)
        }
        
    }
}

struct IndicatorImageView_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorImageView(name: "completed")
            .previewLayout(.sizeThatFits)
    }
}
