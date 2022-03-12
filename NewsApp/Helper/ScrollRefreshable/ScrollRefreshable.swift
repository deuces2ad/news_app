//
//  ScrollRefreshable.swift
//  NewsApp
//
//  Created by Apple on 12/03/22.
//

import Foundation
import SwiftUI


struct ScrollRefreshable<Content: View>: View {
    
    
    var content: Content
    var onRefresh: () async ->()
    
    init(title: String,tintColor: Color,@ViewBuilder content: @escaping ()->Content,onRefresh: @escaping () async ->()){
        
        self.content = content()
        self.onRefresh = onRefresh
        
        // Modifying Refresh Control...
        UIRefreshControl.appearance().attributedTitle = NSAttributedString(string: title)
        UIRefreshControl.appearance().tintColor = UIColor(tintColor)
    }
    
    var body: some View {
        
        List{
            content
                .listRowSeparatorTint(.clear)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listStyle(.plain)
        .refreshable {
            await onRefresh()
        }
    }
}

struct ScrollRefreshable_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
