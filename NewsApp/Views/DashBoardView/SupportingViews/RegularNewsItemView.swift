//
//  RegularNewsItemView.swift
//  NewsApp
//
//  Created by Apple on 12/03/22.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct RegularNewsItemView: View {
    
    var item : Item
    
    var rawUrl : URL{
        var component = URLComponents(string: (item.thumbnail)!)
        component?.queryItems = nil
        return (component?.url)!
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack(spacing:0){
                VStack(alignment: .leading, spacing: 5){
                    
                    Text(item.title!)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 16, weight: .medium))
                        .fixedSize(horizontal: false, vertical: true)
                        
                    
                    Text(DateParser.getFormatedDate(date: item.pubDate!))
                        .font(.system(size: 14, weight: .ultraLight))
                }
                .padding(5)
                
                Spacer()
                WebImage(url: rawUrl)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fill)
                
            }
            .frame(height: 100)
            .padding(.leading)
            .frame(maxWidth:.infinity)
            
        }
        .background(.white)
        .cornerRadius(10)
        .padding()
    }
}
