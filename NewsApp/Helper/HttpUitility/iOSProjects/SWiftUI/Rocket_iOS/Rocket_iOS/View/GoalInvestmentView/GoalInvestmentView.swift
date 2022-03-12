//
//  SelectedGoalView.swift
//  Rocket_iOS
//
//  Created by Apple on 20/01/22.
//

import SwiftUI

struct GoalInvestmentView: View {
    
     // MARK: - PROPERTIES
    
    @State private var sheetMode : SheetMode = .none
    @State private var selectedMonth : String = "1"
    @State private var selectedYear : String = "2022"
    
    var amountToSave : String{
        return CurrencyFormatter.convertToIDRFormat(with: "230000")
    }

    
    var totalEstaimatedAmount : String{
        return CurrencyFormatter.convertToIDRFormat(with: "567830000")
    }
    
    var isLinkActive : Bool{
       return true
    }
    
    var formatedChoosenTime : String{
        return String("\(selectedMonth) Months and \(selectedYear) Year")
    }

     // MARK: - BODY
    
    var body: some View {
        
        ZStack {
            // main content of the view...
            
            VStack{
                NavigationBar(title: .constant("Dreams Come True"))
                
                Text("Investment Simulation")
                    .padding(15)
                
                DreamItemView(selectedImage: "baby_on_floor", itemImage: "baby_on_floor")
                
                
                VStack(spacing:20){
                    
                    VStack(alignment: .leading){
                        
                        Text("How long does it take for a dream to come true?")
                            .font(Font.custom(AppThemeConfig.AvenirFont, size: 14))
                            .foregroundColor(.black)
                        
                        HStack{
                            Text(formatedChoosenTime)
                                .modifier(LightGrayTitle())
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                                .aspectRatio(contentMode: .fit)
                        }
                        .onTapGesture {
                            sheetMode = .half
                        }
                        .modifier(RectangularFrame())
                    }
                    
                    VStack(alignment: .leading){
                        
                        Text("What you have to save")
                            .font(Font.custom(AppThemeConfig.AvenirFont, size: 14))
                            .foregroundColor(.black)
                        
                        HStack{
                            Text("IDR 455")
                            Spacer()
                            Text("/ month")
                        }
                        .modifier(LightGrayTitle())
                        .modifier(RectangularFrame())
                    }
                }
                .padding(.top,45)
                Text(String("Jika Anda berinvestasi \(amountToSave) Bulan Anda bisa membeli mobil baru seharga \(totalEstaimatedAmount) dalam 100 tahun."))
                    .padding()
                    .font(.custom(AppThemeConfig.AvenirFont, size: 14))
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Button(action: {
                   //
                }) {
                    Text("Start")
                        .padding(.vertical,10)
                        .frame(maxWidth:.infinity)
                        .modifier(CustomButtonStyle(
                            forgroundColor: isLinkActive ? AppThemeConfig.themeYellowColor : AppThemeConfig.LightGray ,
                            textColor:isLinkActive ? AppThemeConfig.themeLightBrownColor : .black.opacity(0.5) ))
                }
                .disabled(!isLinkActive)
                .padding(.bottom)
            }
            .padding(.horizontal)
            .overlay(
                Group{
                    if sheetMode == .half{
                        Color.black.opacity(0.5)
                            .edgesIgnoringSafeArea(.all)
                    }
                }
            )
           
            .frame(maxHeight:.infinity)
            
           // Flexible sheet...
           
            FlexibleSheet(sheetMode: $sheetMode){
                PickerView(sheetMode: $sheetMode,selectedMonth: $selectedMonth,selectedYear: $selectedYear)
            }
        }
        .modifier(HideNavigationBar())
    }
}

 // MARK: - PREVIEW
struct SelectedGoalView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group{
            GoalInvestmentView()
                .previewDevice(DeviceList.iPhone8)
            GoalInvestmentView()
                .previewDevice(DeviceList.iPhone13)
            GoalInvestmentView()
                .previewDevice(DeviceList.iPadMini6ThGeneration)
        }
        
    }
}



