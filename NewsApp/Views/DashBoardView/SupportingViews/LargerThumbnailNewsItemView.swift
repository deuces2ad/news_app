//
//  LargerThumbnailNewsItem.swift
//  NewsApp
//
//  Created by Apple on 12/03/22.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI


struct LargerThumbnailNewsItemView: View {
    
    var item : Item
    
    var rawUrl : URL{
        var component = URLComponents(string: (item.enclosure?.link)!)
        component?.queryItems = nil
        return (component?.url)!
    }
    
    var body: some View {
        
        
        VStack(spacing:0){
            
            WebImage(url: rawUrl)
                .resizable()
                .frame(maxWidth:.infinity)
                .frame(height:200)
                .aspectRatio(contentMode: .fit)
            
           
            VStack(alignment: .leading, spacing: 0){
                Text(item.title!)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.system(size: 28, weight: .bold))
                    .frame(maxWidth:.infinity)
                    .frame(height:150)
         
                
                HStack{
                    Text(DateParser.getFormatedDate(date: item.pubDate!))
                        .padding(.vertical,5)
                        .font(.system(size: 18, weight: .ultraLight))
                    Spacer()
                }
            }
            .padding(.leading,10)
            
            
        }
        .background(.white)
        .cornerRadius(10)
        .padding()
    }
    
    
}
