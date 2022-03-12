//
//  BannerView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 22/12/21.
//

import SwiftUI

struct BannerView: View {
    
    @State var imgName : String
    var body: some View {
        VStack {
            Image(imgName)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

struct BannerView_Previews: PreviewProvider {
    static var previews: some View {
        BannerView(imgName: "banner")
            .previewLayout(.sizeThatFits)
    }
}
