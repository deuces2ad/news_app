//
//  LoginAndSignupFields.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 19/12/21.
//

import SwiftUI


struct LoginAndSignupFields: View {
    
     // MARK: - PROPERTIES
    
    let TAG = "LoginAndSignupFields"
    @ObservedObject var loginViewModel : LoginViewModel = LoginViewModel()
    @State private var loginPageSubHeadingTitle : LoginPageHeadingTitle = LoginPageHeadingTitle.Login
    @State private var showLastStep : Bool = false
    @State private var loginPageButtonTitle : LoginPageButtonTitle = .Login
    @State private var loginSignupSwitchBtnTitle : LoginSignupSwitchButtonTitle = .SignupBtnAction
    @State private var isloginSuccessfull : Bool = false
    var UIState: UIStateModel = UIStateModel()
    
     // MARK: - BODY
    
    init(){
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
                
                // MARK: - Login SCREEN
                
                SubHeadingTitleView(title: loginPageSubHeadingTitle)
                    .padding([.top,.leading],5)
                
                //check if Signup last page to be shown...
                if (showLastStep == false) {
                    
                    CustomTextField(title: "Email", placeHolderText: "Enter your registered email..", inputTxt: $loginViewModel.loginDataModel.userEmail)
                    
                    CustomSecureTextFild(title: "Password", placeHolderText: "Enter your password..", userPassword: $loginViewModel.loginDataModel.userPassword)
                    
                    
                    // MARK: - Signup SCREEN
                    
                    if loginViewModel.loginDataModel.isRegisterdUser == false {
                        CustomNavigationButton(title: "forgot Password", content: {
                            ForgotPasswordView()
                        }, isNavigationRequired: true, action: {})
                            .frame(maxWidth:.infinity,alignment: .leading)
                        
                    }else{
                        CustomSecureTextFild(title: "Confirm Password", placeHolderText: "Enter confirm password..", userPassword: $loginViewModel.loginDataModel.userConfirmPassword)   .padding(.top,20)
                        
                    }
                }else{
                    // MARK: - The LAST SCREEN
                    
                    CustomTextField(title: "Name according to your ID Card", placeHolderText: "Type your name according to your ID card", inputTxt: $loginViewModel.loginDataModel.userNameAsPerIdCard)
                    
                    CustomTextField(title: "Telephone Number", placeHolderText: "+62 8XX XXXX XXXX", inputTxt:  $loginViewModel.loginDataModel.userPhnNumber)
                    
                    CustomTextField(title: "Friend's Code", placeHolderText: "Type your friend's code", inputTxt: $loginViewModel.loginDataModel.userReferalCode)
                    
                }
                
                // MARK: - Login/Signup Action
                
                CustomButton(title: loginPageButtonTitle.rawValue, verticlePadding: 10, backgroundColor: AppThemeConfig.themeYellowColor, action: {
                    
                    switch loginPageButtonTitle {
                        
                    case .Login:
                        Log.echo(key: TAG, text: "Login Pressed")
                        if loginViewModel.validateUserInputsForLogin(){
                            
                            Log.echo(key: TAG, text: "Login Succesfull..!!")
                            isloginSuccessfull = true
                        }
                        break
                        
                    case .Signup:
                        Log.echo(key: TAG, text: "Signup Pressed")
                        
                        
                        if loginViewModel.validateUserInputsForSignup(){
                            
                            Log.echo(key: TAG, text: "Signup Succesfull..!!")
                            showLastStep = true
                            loginPageButtonTitle = .Finished
                            loginPageSubHeadingTitle = .TheLastStep
                            loginSignupSwitchBtnTitle = .LastStepAction
                            
                        }
                      
                        break
                        
                    case .Finished:
                        Log.echo(key: TAG, text: "Finished Pressed")
                        if loginViewModel.validateUserInputForFinalStep(){
                            Log.echo(key: TAG, text: "User Register Successfully!!")
                        }
                        //
                        break
                    }
                    
                }).alert(isPresented: $loginViewModel.loginDataModel.isPresentingErrorAlert, content: {
                    Alert(title: Text(AppInfoConfig.appName), message: Text(loginViewModel.loginDataModel.errorMessage), dismissButton: .cancel(Text("Ok")))
                })
                .padding(.top)
                
                // MARK: - Login/Signup screen toggle visibilty...
                
                CustomNavigationButton(title: loginSignupSwitchBtnTitle.rawValue, content: {}, isNavigationRequired: false) {
                    loginPageSubHeadingTitle = loginViewModel.loginDataModel.isRegisterdUser ?
                        .Login : .Signup
                    
                    switch loginSignupSwitchBtnTitle {
                        
                    case .LoginBtnAction:
                        Log.echo(key: TAG, text: "switchToLogin tapped!!")
                        
                        withAnimation {
                            loginViewModel.loginDataModel.isRegisterdUser = false
                            loginPageButtonTitle = .Login
                            loginSignupSwitchBtnTitle = .SignupBtnAction
                        }
                       
                        
                    case .SignupBtnAction:
                        Log.echo(key: TAG, text: "switchToSignup tapped!!")
                        withAnimation {
                            loginViewModel.loginDataModel.isRegisterdUser = true
                            loginPageButtonTitle = .Signup
                            loginSignupSwitchBtnTitle = .LoginBtnAction
                        }
                        
                    case .LastStepAction:
                        Log.echo(key: TAG, text: "switchToLastStep tapped!!")
                        withAnimation {
                            showLastStep = false
                            loginPageSubHeadingTitle = .Signup
                            loginPageButtonTitle = .Signup
                            loginSignupSwitchBtnTitle = .LoginBtnAction
                        }
                    }
                }
                
                NavigationLink("", isActive: $isloginSuccessfull) {
                    // enviroment object is necessary to send otherwise it'll crahes for iOS 13.
                    MainTabView()
                        .environmentObject(UIState)
                        .navigationBarTitle("My Title")
//                        .navigationBarHidden(true)
                }
//                .isDetailLink(false)
            }.padding(30)
        }
    }
}

@available(iOS 15.0, *)
struct LoginAndSignupFields_Previews: PreviewProvider {
    static var previews: some View {
        LoginAndSignupFields()
    }
}
