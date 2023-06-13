//
//  Components.swift
//  NfactorialFinal
//
//  Created by Arip Khozhbanov on 31.05.2023.
//

import SwiftUI

struct Components: View {
    var body: some View {
        ThModal {
            
        }
    }
}


struct MainButton: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 29)
                    .fill(.black)
                    .frame( height: 58)
                Text(title)
                    .foregroundColor(Color.white)
                    .font(.system(size: 19))
                    .bold()
            }
        }.padding(.horizontal)
    }
    
}

struct MainTitle: View {
    
    let title : String
    let color : Color
    
    var body: some View {
        Text(title)
            .font(.system(size: 30, weight: .bold))
            .padding()
            .foregroundColor(color)
    }
}

struct PageControl : UIViewRepresentable {
    
    var currentPageIndex : Int = 0
    var numberOfPages : Int = 0
    
    
    /// Create UIView object and configure the initial state
    /// - Returns: UIPageControl
    func makeUIView(context: Context) -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.numberOfPages = numberOfPages
        
        return pageControl
    }
    
    /// Update the state of UIKit view based on new info given from SwiftUI
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPageIndex
    }
}

struct CoolTextField: View {
    let placeholderT: String
    @Binding var text1: String
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(height: 52)
                .foregroundColor(.init(red: 0.949, green: 0.949, blue: 0.933, opacity: 1))
                .padding(.horizontal)
                .padding(.vertical, 4)
            TextField(placeholderT, text: $text1)
                .foregroundColor(.init(red: 0, green: 0, blue: 0, opacity: 0.3))
                .frame(width: 328)
                .multilineTextAlignment(.leading)
                
        }
    }
    
    func getText() -> String {
        return text1
    }
}

struct NumTextField: View {
    let placeholderT: String
    @Binding var num: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(height: 52)
                .foregroundColor(.init(red: 0.949, green: 0.949, blue: 0.933, opacity: 1))
                .padding(.horizontal)
                .padding(.vertical, 4)
            
            TextField(placeholderT, text: Binding(
                get: { String(num) },
                set: { if let value = Int($0) { num = value } }
            ))
            .foregroundColor(.init(red: 0, green: 0, blue: 0, opacity: 0.3))
            .frame(width: 328)
            .multilineTextAlignment(.leading)
            .keyboardType(.numberPad) 
        }
    }
}

struct PassTextField: View {
    let placeholderT: String
    @Binding var text1: String
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(height: 52)
                .foregroundColor(.init(red: 0.949, green: 0.949, blue: 0.933, opacity: 1))
                .padding(.horizontal)
                .padding(.vertical, 4)
            
            SecureField(placeholderT, text: $text1)
                .foregroundColor(.init(red: 0, green: 0, blue: 0, opacity: 0.3))
                .frame(width: 328)
                .multilineTextAlignment(.leading)
                
        }
    }
    
    func getText() -> String {
        return text1
    }
}

struct CustomCell: View {
    
    @EnvironmentObject var db : FirestoreDB
    var id: Int
    
   
    
    var image: String
    var text: String
    var desc: String
    var price: Int
    let action: () -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .foregroundColor(.white)
                .frame(width: 174, height: 340)
            VStack {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 166, height: 166)
                
                HStack {
                    Text(text)
                        .font(.headline)
                        .padding(.horizontal , 4)
                    Spacer()
                }
                
                HStack {
                    Text(desc)
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .padding(.horizontal , 4)
                        .padding(.vertical , 1)
                    Spacer()
                }

                HStack {
                    Text("$\(price)")
                        .font(.headline)
                        .padding(.horizontal,4)
                    Spacer()
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 17)
                        .frame(width: 166,height: 36)
                        .foregroundColor( db.products[id].isTabbed ? .gray : .black)
                        .animation(.spring())
                    Text( db.products[id].isTabbed ? "Remove" : "Add to cart")
                        .animation(.spring())
                        .foregroundColor(.white)
                }.padding(4)
                    .padding(.bottom , 8)
                    .onTapGesture {
                        db.products[id].isTabbed.toggle()
                        action()
                    }
                
            }
        }
        
    }
    
    
    
}

struct ThModal: View {
    let action: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(height: 630)
                .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
            VStack {
                Image("Modal1")
                    .resizable()
                    .frame(width: 340,height: 200)
                    .offset(x: -50, y: 58)
                    .zIndex(1)
                Image("Modal2")
                    .resizable()
                    .frame(width: 278,height: 210)
                Spacer()
                
                MainTitle(title: "Your order is succesfully placed. Thanks!", color: .black)
                MainButton(title: "Get back to shopping") {
                    action()
                }.padding(.bottom, 80)
                Spacer()
                Spacer()
                HStack {
                    Spacer()
                }
                .frame(height: 90)
            }
        }
    }
}


struct Components_Previews: PreviewProvider {
    static var previews: some View {
        Components()
    }
}
