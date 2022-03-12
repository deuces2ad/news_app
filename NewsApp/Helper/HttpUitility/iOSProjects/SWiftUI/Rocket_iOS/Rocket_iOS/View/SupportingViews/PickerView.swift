//
//  PickerView.swift
//  Rocket_iOS
//
//  Created by Apple on 21/01/22.
//

import Foundation
import SwiftUI


let months: [Int] = Array(1...12)
let years : [Int] = Array(2022...2050)

struct PickerView: View {
    
    // MARK: - Properties
    
    @Binding var sheetMode : SheetMode
    @Binding var selectedMonth : String
    @Binding var selectedYear : String
    
     // MARK: - Body
    
    var body: some View {
        ZStack{
            Color.white
            
            VStack{
                
                RoundedRectangle(cornerRadius: 6)
                  
                    .foregroundColor(AppThemeConfig.LightGray)
                    .frame(width: 50, height: 5)
                    .padding(.top,3)
                
                HStack{
                    Text("Waktu")
                        .font(.custom(AppThemeConfig.AvenirFont, size: 21))
                        .padding(10)
                    Spacer()
                }
                
                RoundedRectangle(cornerRadius: 6)
                    .foregroundColor(AppThemeConfig.LightGray)
                    .frame(width: getRect().width * 0.90, height: 1.5)
                
                VStack(alignment: .leading,spacing:0){
                HStack{
                    Spacer()
                    Text("Months")
                    Spacer()
                    Text("Years")
                    Spacer()
                }
                .font(.custom(AppThemeConfig.AvenirFont, size: 18).weight(.semibold))
                .padding(.top)

            
                    CustomPicker(selectedMonth: $selectedMonth, selectedYear: $selectedYear)
                        .frame(maxWidth:.infinity)
                    .background(
                        VStack(alignment: .center){
                            AppThemeConfig.themeLightYellowColor
                                .frame(width: getRect().width, height: 50)
                        }
                    )
                    Button(action: {
                        sheetMode = .none
                    }) {
                        Text("Save")
                            .padding(.vertical,8)
                            .frame(maxWidth:.infinity)
                            .modifier(CustomButtonStyle(forgroundColor: AppThemeConfig.themeYellowColor))
                    }
                }
                             
                Spacer()
                
            }
            .padding()
        }
        .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
    }
}


struct CustomPicker : UIViewRepresentable {
    
    @Binding var selectedMonth : String
    @Binding var selectedYear : String
    
    func makeCoordinator() -> Coordinator {
        return CustomPicker.Coordinator(parent1: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<CustomPicker>) ->  UIPickerView {
        let picker = UIPickerView()
        picker.delegate = context.coordinator
        picker.dataSource = context.coordinator
        return picker
    }
    
    func updateUIView(_ uiView: UIPickerView, context: Context) {
        //
    }
    
    class Coordinator : NSObject,UIPickerViewDelegate,UIPickerViewDataSource {
        
        var parent: CustomPicker
        
        init(parent1 : CustomPicker){
            self.parent = parent1
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 2
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
          
            return component == 0 ? months.count : years.count
           
        }
        
        
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            
            pickerView.subviews.forEach { $0.backgroundColor = .clear }

            let view = UIView(frame: CGRect(x: 0, y: 0, width:800, height: 60))
    
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
            label.text =  component == 0 ? String(months[row]) : String(years[row])
            label.font = UIFont(name: AppThemeConfig.AvenirFont, size: 18)
            label.font = UIFont.boldSystemFont(ofSize: 18)
            label.textColor = UIColor(hexString: "824529")
            label.textAlignment = .center
            view.backgroundColor = .clear
            view.addSubview(label)
            return view

        }
        
        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 50
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if component == 0 {
                self.parent.selectedMonth = String(months[row])
            }else{
                self.parent.selectedYear = String(years[row])
            }
        }
    }
    
}



