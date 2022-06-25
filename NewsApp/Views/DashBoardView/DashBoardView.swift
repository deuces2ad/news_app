//
//  DashBoardView.swift
//  NewsApp
//
//  Created by Apple on 12/03/22.
//

import SwiftUI

struct DashBoardView: View {
    
    @ObservedObject var dashBoardViewModal = DashBoardViewModel()
    @State var items : Item?
    
    var body: some View {
        
        VStack(alignment: .center,spacing:0) {
            HStack{
                Text("GeeksForGeeks")
                    .foregroundColor(.green)
                    .font(.system(size: 18, weight: .bold))
                    .frame(height:50)
               Spacer()
            }
            .padding(.leading)
            .background(.white)
           
            
            ScrollRefreshable(title: "Pull Down", tintColor: .gray, content: {
                    ForEach((dashBoardViewModal.newsFeeditems)){ item in
                        if item.title == dashBoardViewModal.newsFeeditems[0].title{
                            LargerThumbnailNewsItemView(item: item)
                            
                        }else{
                            RegularNewsItemView(item: item)
                        }
                    }

            }){
                dashBoardViewModal.fetchNewsFeed()
                await Task.sleep(2_000_000_000)
            }
            
        }
       
        .onAppear(perform: {
            dashBoardViewModal.fetchNewsFeed()
        })
        
        .background(.gray)
        
    }
}

struct DashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        DashBoardView()
    }
}



