//
//  NumpadView.swift
//  Rocket_iOS
//
//  Created by Apple on 19/01/22.
//

import SwiftUI

enum NumpadButton : String{
    case zero , one , two , three, four , five , six , seven , eight , nine
    case fingerPrint , delete
    
    var title : String{
        switch self{
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .fingerPrint: return "securityCheck"
        case .delete: return "delete_cross"
        }
    }
    
    var isSpecialCharacter : Bool{
        switch self {
        case .zero,.one,.two,.three,.four,.five,.six,.seven,.eight,.nine:
            return false
            
        case .fingerPrint,.delete:
            return true
        }
    }
}

class NumpadGlobalObject : ObservableObject{
    
    @Published var display : String = "0"
    
    func receiveInput(numpadButton : NumpadButton){
        self.display = display + numpadButton.title
    }
    
    func
    deleteOperation(){
        self.display = String(self.display.dropLast())
    }
}

struct NumpadView: View {
    
    @EnvironmentObject var env : NumpadGlobalObject
    
    let buttons : [[NumpadButton]] = [
        [.one,.two,.three],
        [.four,.five,.six],
        [.seven,.eight,.nine],
        [.fingerPrint,.zero,.delete],
    ]
    
    var body: some View {
    
            VStack(alignment: .trailing,spacing:12) {

                ForEach(buttons, id:\.self){ row in
                    
                    HStack(spacing:30){
                        
                        ForEach(row, id:\.self) { button in
                            
                           NumpadButtonView(numbpad: button)
                            
                        }
                    }
                }
               
            }
            .padding(.bottom)
        
    }
   
}


struct NumpadView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            NumpadView()
                .previewDevice(DeviceList.iPhone8)
            NumpadView()
                .previewDevice(DeviceList.iPhone13)
            NumpadView()
                .previewDevice(DeviceList.iPadMini6ThGeneration)
        }
       
            .environmentObject(NumpadGlobalObject())
    }
}
