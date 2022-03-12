//
//  TransparentView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 27/12/21.
//

import SwiftUI

struct TransparentView: View {
    
    var body: some View {
        BasicUIviewRepresentable()
            .edgesIgnoringSafeArea(.all)
    }
}

struct TransparentView_Previews: PreviewProvider {
    static var previews: some View {
        TransparentView()
    }
}


struct BasicUIviewRepresentable : UIViewRepresentable{
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
         //
    }
}
