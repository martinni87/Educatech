////
////  CustomTextField.swift
////  Educatech
////
////  Created by Martín Antonio Córdoba Getar on 8/10/23.
////
//
//import SwiftUI
//
//struct CustomTextField: View {
//    
//    @Environment (\.colorScheme) var colorScheme
//    
//    @State var fieldType: FormFieldTypes
//    @State var label: String
//    @State var placeholder: String
//    @State var tooltip: String?
//    @Binding var variable: String
//    @State var autocapitalization: Bool
//    
//    @State var editing = false
//    @State var showTooltip = false
//    @State var tooltipTimer: Timer?
//    
//    var body: some View {
//        VStack (alignment: .leading) {
//            Text(label)
//                .foregroundColor(.gray)
//                .bold()
//            VStack (alignment: .trailing) {
//                Rectangle()
//                    .fill(colorScheme == .light ? .black.opacity(0.1) : .white.opacity(0.1))
//                    .frame(height: fieldType == .multiLine ? 200 : 50)
//                    .cornerRadius(10)
//                    .overlay {
//                        switch fieldType {
//                        case .singleLine:
//                            HStack {
//                                TextField(placeholder, text: $variable)
//                                    .textInputAutocapitalization(!autocapitalization ? .never : .sentences)
//                                    .textFieldStyle(.plain)
//                                    .padding()
//                                Image(systemName: "questionmark.bubble")
//                                    .onTapGesture(perform: {
//                                        showTooltip.toggle()
//                                        
//                                        // Hide tooltip after 2 seconds
//                                        tooltipTimer?.invalidate()
//                                        tooltipTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { _ in
//                                            showTooltip = false
//                                        })
//                                    })
//                                    .foregroundColor(.gray)
//                                    .padding()
//                            }
//                            
//                        case .multiLine:
//                            TextEditor(text: $variable)
//                                .cornerRadius(8)
//                                .underline(color: .red)
//                                .foregroundColor(editing ? (colorScheme == .light ? .black : .white) : .gray)
//                                .padding()
//                                .onTapGesture {
//                                    if !editing {
//                                        variable = ""
//                                        editing = true
//                                    }
//                                }
//                        case .secure:
//                            HStack {
//                                SecureField(placeholder, text: $variable)
//                                    .textInputAutocapitalization(!autocapitalization ? .never : .sentences)
//                                    .textFieldStyle(.plain)
//                                    .padding()
//                                Image(systemName: "questionmark.bubble")
//                                    .onTapGesture(perform: {
//                                        showTooltip.toggle()
//                                        
//                                        // Hide tooltip after 2 seconds
//                                        tooltipTimer?.invalidate()
//                                        tooltipTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { _ in
//                                            showTooltip = false
//                                        })
//                                    })
//                                    .foregroundColor(.gray)
//                                    .padding()
//                            }
//                        case .popMenuList:
//                            HStack {
//                                Menu {
//                                    Button {
//                                        variable = "Swift"
//                                    } label: {
//                                        Text("Swift")
//                                    }
//                                    Button {
//                                        variable = "Android"
//                                    } label: {
//                                        Text("Android")
//                                    }
//                                    Button {
//                                        variable = "Web Development"
//                                    } label: {
//                                        Text("Web Development")
//                                    }
//                                } label: {
//                                    Text("\(variable == "" ? label : variable)")
//                                        .foregroundStyle(variable == "" ? .gray : .black)
//                                        .padding(.leading)
//                                    Spacer()
//                                }
//                                Spacer()
//                                Image(systemName: "questionmark.bubble")
//                                    .onTapGesture(perform: {
//                                        showTooltip.toggle()
//                                        
//                                        // Hide tooltip after 2 seconds
//                                        tooltipTimer?.invalidate()
//                                        tooltipTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { _ in
//                                            showTooltip = false
//                                        })
//                                    })
//                                    .foregroundColor(.gray)
//                                    .padding()
//                            }
//                        }
//                    }
//                Text(tooltip ?? "Needed \(label)")
//                    .multilineTextAlignment(.trailing)
//                    .foregroundStyle(showTooltip ? .gray : .clear)
//            }
//            
//        }
//    }
//}
//
//struct RegisterHeaderPart: View {
//    
//    var body: some View {
//        VStack {
//            Text("Register")
//                .font(.title)
//                .bold()
//            Spacer()
//            Image("register_pic")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 100)
//            Spacer()
//            Text("Fill the form to successfully register an email account.")
//                .multilineTextAlignment(.center)
//                .foregroundStyle(Color.gray)
//                .bold()
//                .padding(.horizontal, 20)
//        }
//    }
//}
//
//struct RegisterFormPart: View {
//    
//    @ObservedObject var authViewModel: AuthViewModel
//    @ObservedObject var userViewModel: UserViewModel
//    @Binding var email: String
//    @Binding var nickname: String
//    @Binding var password: String
//    @Binding var repeatPassword: String
//    @Binding var thereIsError: Bool
//    
//    var body: some View {
//        ScrollView {
//            CustomTextField(fieldType: .singleLine,
//                            label: "Email",
//                            placeholder: "jondoe@mail.com",
//                            variable: $email,
//                            autocapitalization: false)
//            CustomTextField(fieldType: .singleLine,
//                            label: "Nickname",
//                            placeholder: "User name",
//                            variable: $nickname,
//                            autocapitalization: true)
//            CustomTextField(fieldType: .secure,
//                            label: "Password",
//                            placeholder: "*******",
//                            variable: $password,
//                            autocapitalization: false)
//            CustomTextField(fieldType: .secure,
//                            label: "Repeat Password",
//                            placeholder: "*******",
//                            variable: $repeatPassword,
//                            autocapitalization: false)
//            Button("Register"){
//                authViewModel.signUpEmail(email: email,
//                                          nickname: nickname,
//                                          password: password,
//                                          repeatPassword: repeatPassword,
//                                          userViewModel: userViewModel)
//                if let _ = authViewModel.error {
//                    thereIsError = true
//                }
//            }
//            .buttonStyle(.bordered)
//            .tint(.green)
//        }
//        .textInputAutocapitalization(.never)
//        .textFieldStyle(.roundedBorder)
//        
//    }
//}
//
//struct CustomTextField_Preview: PreviewProvider {
//    
//    @State static var variable = ""
//    static var previews: some View {
//        VStack {
//            CustomTextField(fieldType: .singleLine,
//                            label: "Example",
//                            placeholder: "jondoe@mail.com",
//                            variable: $variable,
//                            autocapitalization: false)
//            CustomTextField(fieldType: . secure,
//                            label: "Example",
//                            placeholder: "jondoe@mail.com",
//                            variable: $variable,
//                            autocapitalization: false)
//            CustomTextField(fieldType: .popMenuList,
//                            label: "Example",
//                            placeholder: "jondoe@mail.com",
//                            variable: $variable,
//                            autocapitalization: false)
//            CustomTextField(fieldType: .multiLine,
//                            label: "Example",
//                            placeholder: "jondoe@mail.com",
//                            variable: $variable,
//                            autocapitalization: false)
//        }
//    }
//}
//
