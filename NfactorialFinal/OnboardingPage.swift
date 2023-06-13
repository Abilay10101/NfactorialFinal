//
//  OnboardingPage.swift
//  NfactorialFinal
//
//  Created by Arip Khozhbanov on 01.06.2023.
//

import SwiftUI

struct OnboardingPage: View {
    
    @State var currentPageIndex : Int = 0
    @Binding var screenState : Int
    
    var body: some View {
        ZStack {
            switch currentPageIndex {
            case 0:
                ElementPositions(title1: "OImg2", title2: "OImg1", title3: "OImg3")
            case 1:
                ElementPositions(title1: "OImg22", title2: "OImg21", title3: "OImg23")
            case 2:
                ElementPositions(title1: "OImg32", title2: "OImg31", title3: "OImg33")
            default:
                ElementPositions(title1: "OImg2", title2: "OImg1", title3: "OImg3")
            }
            
            VStack {
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 390, height: 450)
                        .background(.ultraThinMaterial)
                    VStack {
                        PageControl(currentPageIndex: currentPageIndex , numberOfPages: 3)
                        MainTitle(title: "Fast shipping", color: .white)
                        Text("Get all of your desired sneakers in one place.")
                            .foregroundColor(.white)
                            .font(.system(size: 17))
                            .padding(.bottom)
                        MainButton(title: "Next") {
                            if currentPageIndex != 2 {
                                currentPageIndex += 1
                            } else {
                                screenState += 1
                            }
                        }.padding()
                        
                        HStack {
                            Spacer()
                        }.frame(height: 170)
                    }
                    
                }
                
            }
        }
    }
    
}

struct ElementPositions: View {
    
    var title1: String
    var title2: String
    var title3: String
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Spacer()
                Spacer()
                Image(title1)
                    .resizable()
                    .frame(width: 272,height: 192)
                Spacer()
            }.offset(y: 250)
            .zIndex(1)
                
            Image(title2)
                .resizable()
                .frame(width: 398,height: 532)
            Image(title3)
                .resizable()
                .frame(width: 580,height: 442)
                .rotationEffect(.degrees(-2))
                .zIndex(1)
                .offset(y: -80)
        }
    }
}
