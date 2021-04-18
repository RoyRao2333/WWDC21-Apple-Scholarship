//
//  ChapterIIViewController.swift
//  WWDC_raw
//
//  Created by Roy Rao on 2021/4/17.
//

import SwiftUI
import AVKit

public struct Chapter2ViewController: View {
    @State var currentPage: Chapter2GamePages = .preface
    
    public init() {}
    
    public var body: some View {
        currentPage.present($currentPage)
            .frame(width: 800, height: 650)
    }
}


enum Chapter2GamePages {
    case preface
    case it
    case tp
    case cal
    
    @ViewBuilder
    func present(_ cur: Binding<Chapter2GamePages>) -> some View {
        switch self {
        case .preface:
            Chapter2PrefacePage(currentPage: cur)
        case .it:
            ITGamePage(currentPage: cur)
        case .tp:
            TPGamePage(currentPage: cur)
        case .cal:
            ITCalculator(currentPage: cur)
        }
    }
}
