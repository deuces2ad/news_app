//
//  SnapCarousal.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 23/12/21.
//

import SwiftUI


struct SnapCarousel: View {
    
    var UIState: UIStateModel
    @State var showDeatilsInfo : Bool = false
    
    var body: some View
    {
        let spacing:            CGFloat = 8
        let widthOfHiddenCards: CGFloat = 16    // UIScreen.main.bounds.width - 10
        let cardHeight:         CGFloat = 140
        
        let items = [
            Card( id: 0, name: "Hey" ),
            Card( id: 1, name: "Ho" ),
            Card( id: 2, name: "Lets" ),
            Card( id: 3, name: "Go" )
        ]
        
        return  Canvas
        {
            //
            // TODO: find a way to avoid passing same arguments to Carousel and Item
            //
            Carousel( numberOfItems: CGFloat( items.count ), spacing: spacing, widthOfHiddenCards: widthOfHiddenCards )
            {
                ForEach( items, id: \.self.id ) { item in
                    Item( _id:                  Int(item.id),
                          spacing:              spacing,
                          widthOfHiddenCards:   widthOfHiddenCards,
                          cardHeight:           cardHeight )
                    {
                        BannerView(imgName: "banner")
                            .onTapGesture {
                                showDeatilsInfo = true
                            }
                        
                    }
                    .foregroundColor( Color.red )
                    .cornerRadius( 8 )
                    //                                .shadow( color: Color( "shadow1" ), radius: 4, x: 0, y: 4 )
                    .transition( AnyTransition.slide )
                    .animation( .spring() )
                    
                }
                NavigationLink(destination: ForgotPasswordView()
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)
                                .navigationBarTitle("Banner",displayMode: .inline)
                                .navigationViewStyle(.stack), isActive: $showDeatilsInfo){}
                                .isDetailLink(false)
            }
            .environmentObject( self.UIState )
        }
      
    }
}

struct Card: Decodable, Hashable, Identifiable {
    var id: Int
    var name: String = ""
}

public class UIStateModel: ObservableObject {
    @Published var activeCard: Int = 0
    @Published var screenDrag: Float = 0.0
}

struct Carousel<Items : View> : View {
    let items: Items
    let numberOfItems: CGFloat //= 8
    let spacing: CGFloat //= 16
    let widthOfHiddenCards: CGFloat //= 32
    let totalSpacing: CGFloat
    let cardWidth: CGFloat
    
    @GestureState var isDetectingLongPress = false
    
    @EnvironmentObject var UIState: UIStateModel
        
    @inlinable public init(
        numberOfItems: CGFloat,
        spacing: CGFloat,
        widthOfHiddenCards: CGFloat,
        @ViewBuilder _ items: () -> Items) {
        
        self.items = items()
        self.numberOfItems = numberOfItems
        self.spacing = spacing
        self.widthOfHiddenCards = widthOfHiddenCards
        self.totalSpacing = (numberOfItems - 1) * spacing
        self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards*2) - (spacing*2) //279
        
    }
    
    var body: some View {
        let totalCanvasWidth: CGFloat = (cardWidth * numberOfItems) + totalSpacing
        let xOffsetToShift = (totalCanvasWidth - UIScreen.main.bounds.width) / 2
        let leftPadding = widthOfHiddenCards + spacing
        let totalMovement = cardWidth + spacing
                
        let activeOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(UIState.activeCard) )
        let nextOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(UIState.activeCard) + 1)

        var calcOffset = Float(activeOffset)
        
        if (calcOffset != Float(nextOffset)) {
            calcOffset = Float(activeOffset) + UIState.screenDrag
        }
        
        return HStack(alignment: .center, spacing: spacing) {
            items
        }
        .offset(x: CGFloat(calcOffset), y: 0)
        .gesture(DragGesture().updating($isDetectingLongPress) { currentState, gestureState, transaction in
            self.UIState.screenDrag = Float(currentState.translation.width)
            
        }.onEnded { value in
            self.UIState.screenDrag = 1
            
            if (value.translation.width < -50) {
                if CGFloat(UIState.activeCard) == CGFloat(numberOfItems - 1) {return}
                self.UIState.activeCard = self.UIState.activeCard + 1
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
                Log.echo(key: "iNdex", text: "\(UIState.activeCard)")
            }
            
            if (value.translation.width > 50) {
                if UIState.activeCard == 0 {return}
                self.UIState.activeCard = self.UIState.activeCard - 1
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
                Log.echo(key: "iNdex", text: "\(UIState.activeCard)")
            }
        })
    }
}

struct Canvas<Content : View> : View {
    let content: Content
    @EnvironmentObject var UIState: UIStateModel
    
    @inlinable init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

struct Item<Content: View>: View {
    @EnvironmentObject var UIState: UIStateModel
    let cardWidth: CGFloat
    let cardHeight: CGFloat

    var _id: Int
    var content: Content

    @inlinable public init(
        _id: Int,
        spacing: CGFloat,
        widthOfHiddenCards: CGFloat,
        cardHeight: CGFloat,
        @ViewBuilder _ content: () -> Content
    ) {
        self.content = content()
        self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards*2) - (spacing*2) //279
        self.cardHeight = cardHeight
        self._id = _id
    }

    var body: some View {
        content
            .frame(width: cardWidth, height: _id == UIState.activeCard ? cardHeight : cardHeight - 15, alignment: .center)
    }
}

//struct SnapCarousel_Previews: PreviewProvider {
//    static var previews: some View {
//        SnapCarousel()
//    }
//}
//struct SnapCarousal< Content:View,T: Identifiable >: View {
//
//
//     // MARK: - PROPERTIES
//
//    var content: (T) -> Content
//    var lists : [T]
//
//    var spacing : CGFloat
//    var trailingspace : CGFloat
//    @Binding var index : Int
//
//    init(spacing:CGFloat = 15, trailingSpace: CGFloat = 100, index: Binding<Int>,items: [T],@ViewBuilder content : @escaping (T) -> Content){
//        self.lists = items
//        self.spacing = spacing
//        self.trailingspace = trailingSpace
//        self._index = index
//        self.content = content
//    }
//
//    @GestureState var offset : CGFloat = 0
//    @State var curentIndex :Int = 0
//    var body: some View{
//        GeometryReader{ proxy in
////            content
//            let width = proxy.size.width - (trailingspace - spacing)
//
//            HStack(spacing: spacing){
//                ForEach(lists){ item in
//
//                    content(item)
//                        .frame(width: proxy.size.width - trailingspace)
//                }
//            }
//            .padding(.horizontal,spacing)
//            .offset(x:(CGFloat(curentIndex) * -width) +  offset)
//            .gesture(
//
//                DragGesture()
//                    .updating($offset, body: { value, out, _ in
//                        out = value.translation.width
//                    })
//                    .onEnded({ value in
//                        let offsetX = value.translation.width
//                         let progress = -offsetX / width
//                        let roundedIndex = progress.rounded()
//                        curentIndex += max(min(curentIndex + Int(roundedIndex) ,lists.count - 1), 0)
//                    })
//            )
//
//        }
//        .animation(.easeInOut, value: offset == 0)
//    }
//
//
//}
//
//struct SnapCarousal_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
