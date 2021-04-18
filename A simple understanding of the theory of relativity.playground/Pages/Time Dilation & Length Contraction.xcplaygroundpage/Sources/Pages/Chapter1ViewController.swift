//
//  ChapterIViewController.swift
//
//  Created by Roy Rao on 2021/4/10.
//

import SwiftUI

public struct Chapter1ViewController: View {
    @State var currentPage: Chapter1GamePages = .preface
    
    public init() {}
    
    public var body: some View {
        currentPage.present($currentPage)
            .frame(width: 800, height: 650)
    }
}


enum Chapter1GamePages {
    case preface
    case td
    case lc
    
    @ViewBuilder
    func present(_ cur: Binding<Chapter1GamePages>) -> some View {
        switch self {
        case .preface:
            Chapter1PrefacePage(currentPage: cur)
        case .td:
            TDGamePage(currentPage: cur)
        case .lc:
            LCGamePage(currentPage: cur)
        }
    }
}
