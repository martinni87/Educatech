////
////  CreationForm.swift
////  Educatech
////
////  Created by Martín Antonio Córdoba Getar on 16/10/23.
////
//
//import SwiftUI
//
//struct CreationForm: View {
//    
//    //Form values
//    @Binding var formParameters: CreationFormParameters
//    let categories = ["Swift", "Kotlin", "Web Development", "Testing Automation"]
//    
//    var body: some View {
//        VStack {
//            CustomTextField(fieldType: .singleLine,
//                            label: "Title",
//                            placeholder: "Title",
//                            variable: $formParameters.title,
//                            autocapitalization: true)
//            CustomTextField(fieldType: .singleLine,
//                            label: "Image URL",
//                            placeholder: "https://www.image.com/image.jpg",
//                            tooltip: "You can choose any picture you like from the internet if you have a valid URL address",
//                            variable: $formParameters.imageURL,
//                            autocapitalization: false)
//            CustomTextField(fieldType: .multiLine,
//                            label: "Description",
//                            placeholder: "Write some description here...",
//                            variable: $formParameters.description,
//                            autocapitalization: true)
//            CustomTextField(fieldType: .popMenuList,
//                            label: "Category",
//                            placeholder: "Swift",
//                            tooltip: "Select a category from the list",
//                            variable: $formParameters.category,
//                            autocapitalization: false)
////            CustomTextField(fieldType: .singleLine,
////                            label: "Price",
////                            placeholder: "0.99",
////                            tooltip: "You are free to set any price. But keep in mind that low priced courses have more chance to get students!",
////                            variable: $formParameters.price,
////                            autocapitalization: false)
//        }
//    }
//}
//
//struct CreationForm_Previews: PreviewProvider {
//    
//    @State static var formParameters = CreationFormParameters()
//    
//    static var previews: some View {
//        CreationForm(formParameters: $formParameters)
//    }
//}
