//
//  FirstView.swift
//  CredSample
//
//  Created by Apple on 22/02/22.
//

import SwiftUI

struct FirstView: View {
    
    var body: some View {
        
            List(places) { place in
                Text(place.name)
                
            }
        }
    }


struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}

let places = [
    Place(id: 1, name: "Chandigarh"),
    Place(id: 2, name: "panchkula"),
    Place(id: 3, name: "Mohali")
]


