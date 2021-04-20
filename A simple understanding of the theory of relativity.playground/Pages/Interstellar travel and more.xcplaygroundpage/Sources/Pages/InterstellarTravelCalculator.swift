//
//  InterstellarTravelCalculator.swift
//  WWDC_raw
//
//  Created by Roy Rao on 2021/4/17.
//

import SwiftUI
import Combine

struct ITCalculator: View {
    @Binding var currentPage: Chapter2GamePages
    @State private var showAlert: Bool = false
    @State private var text_c: String = ""
    @State private var text_distance: String = ""
    @State private var text_dilatedDistance: String = ""
    @State private var text_forEarth: String = ""
    @State private var text_forYou: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Your velocity is")
                    .font(.system(size: 15, weight: .regular, design: .monospaced))
                    .fixedSize()
                    .padding(.horizontal, 10)
                TextField("", text: $text_c)
                    .frame(maxWidth: 100)
                Text("%   of the speed of light.")
                    .font(.system(size: 15, weight: .regular, design: .monospaced))
                    .fixedSize()
                    .padding(.trailing, 10)
            }
            .padding()
            .onReceive(Just(text_c)) { newValue in
                let filtered = newValue.filter { "0123456789.".contains($0) }
                if filtered != newValue {
                    text_c = filtered
                }
            }
            
            HStack {
                Text("The planet you wanna visit is")
                    .font(.system(size: 15, weight: .regular, design: .monospaced))
                    .fixedSize()
                    .padding(.horizontal, 10)
                TextField("", text: $text_distance)
                    .frame(maxWidth: 100)
                Text("light-years away from earth.")
                    .font(.system(size: 15, weight: .regular, design: .monospaced))
                    .fixedSize()
                    .padding(.horizontal, 10)
            }
            .padding()
            .onReceive(Just(text_distance)) { newValue in
                let filtered = newValue.filter { "0123456789.".contains($0) }
                if filtered != newValue {
                    text_distance = filtered
                }
            }
            
            Button {
                if let per = Double(text_c), per <= 100 && Double(text_distance) != nil {
                    let dist = Double(text_distance)!
                    
                    let result = calculate(cPercentage: per, distance: dist)
                    text_dilatedDistance = "\(result[.dilatedDistance]!.roundTo(places: 2))"
                    text_forEarth = "\(result[.timeForEarth]!.roundTo(places: 2))"
                    text_forYou = "\(result[.timeForYou]!.roundTo(places: 2))"
                } else {
                    showAlert = true
                }
            } label: {
                Text("Calculate!")
                    .fixedSize()
                    .padding()
                    .foregroundColor(.white)
                    .background(
                        LinearGradient(
                                    gradient: Gradient(colors: [.red, .blue]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                        )
                    )
                    .cornerRadius(40)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.vertical, 50)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Input error!"),
                    message: Text("Please check your input and try again! (Your velocity should be between 0 and 100 percentage of the speed of light)"),
                    dismissButton: .default(Text("Got it!"))
                )
            }
            
            HStack {
                Text("The distance you need to travel is dilated to")
                    .font(.system(size: 15, weight: .regular, design: .monospaced))
                    .fixedSize()
                    .padding(.horizontal, 10)
                Text(text_dilatedDistance)
                    .font(.system(size: 20, weight: .regular, design: .monospaced))
                    .fixedSize()
                    .padding(.trailing, 10)
                Text("light-years!")
                    .font(.system(size: 15, weight: .regular, design: .monospaced))
                    .fixedSize()
                    .padding(.trailing, 10)
            }
            .padding()
            
            HStack {
                Text("The journey time viewed from the earth is")
                    .font(.system(size: 15, weight: .regular, design: .monospaced))
                    .fixedSize()
                    .padding(.horizontal, 10)
                Text(text_forEarth == "inf" ? "infinite" : text_forEarth)
                    .font(.system(size: 20, weight: .regular, design: .monospaced))
                    .fixedSize()
                    .padding(.trailing, 10)
                Text("years!")
                    .font(.system(size: 15, weight: .regular, design: .monospaced))
                    .fixedSize()
                    .padding(.trailing, 10)
            }
            .padding()
            
            HStack {
                Text("The journey time viewed from your spacecraft is")
                    .font(.system(size: 15, weight: .regular, design: .monospaced))
                    .fixedSize()
                    .padding(.horizontal, 10)
                Text(text_forYou == "inf" ? "infinite" : text_forYou)
                    .font(.system(size: 20, weight: .regular, design: .monospaced))
                    .fixedSize()
                    .padding(.trailing, 10)
                Text("years!")
                    .font(.system(size: 15, weight: .regular, design: .monospaced))
                    .fixedSize()
                    .padding(.trailing, 10)
            }
            .padding(.bottom, 100)
            
            Button {
                currentPage = .preface
            } label: {
                Text("Back to menu")
                    .fixedSize()
                    .padding()
                    .foregroundColor(.white)
                    .background(
                        LinearGradient(
                                    gradient: Gradient(colors: [.red, .blue]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                        )
                    )
                    .cornerRadius(40)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.bottom, 20)
        }
    }
}



fileprivate func calculate(cPercentage per: Double, distance dist: Double) -> [CalParam: Double] {
    let dilationValue = dist * sqrt(1 - pow(per, 2) / pow(100, 2))
    let valueForEarth = dist * (100 / per)
    let valueForYou = dilationValue / (per * 0.01)
    
    return [
        .dilatedDistance: dilationValue,
        .timeForEarth: valueForEarth,
        .timeForYou: valueForYou
    ]
}


enum CalParam {
    case dilatedDistance
    case timeForEarth
    case timeForYou
}
