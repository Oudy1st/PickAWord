//
//  ContentView.swift
//  PickAWord
//
//  Created by Detchat Boonpragob on 2/7/2565 BE.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            Text("Please, pick some word to say!")
                .padding()
            
            Text(viewModel.pickedWord)
                .foregroundColor(.green)
                .padding()
            
            Button {
                viewModel.pickAWord(isUsingCombine: true)
            } label: {
                Text("pick a word")
                    .font(.system(size: 18))
                    .padding()
                    .foregroundColor(.blue)
            }
            .overlay(
                Capsule(style: .continuous)
                    .stroke(.blue, style: StrokeStyle(lineWidth: 5))
            )
            
            Button {
                viewModel.pickDuoWord(isUsingCombine: false)
            } label: {
                Text("pick duo word")
                    .font(.system(size: 18))
                    .padding()
                    .foregroundColor(.mint)
            }
            .overlay(
                Capsule(style: .continuous)
                    .stroke(.mint, style: StrokeStyle(lineWidth: 5))
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
