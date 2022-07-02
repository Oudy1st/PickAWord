//
//  ContentViewModel.swift
//  PickAWord
//
//  Created by Detchat Boonpragob on 2/7/2565 BE.
//

import Foundation
import UIKit
import Combine

class ContentViewModel: ObservableObject {
    @Published var pickedWord:String = "Combine!"
    var cancellables = Set<AnyCancellable>()
    
    func pickAWord(isUsingCombine:Bool = true) {
        let title = "Pick a word"
        let message:String? = nil
        
        if isUsingCombine {
            AlertUseCase().execute(title: title, message: message,
                                   buttons: [AlertButton(text: "Hello", style: .default, alertResponseType: .text(text: "Hello Combine!")),
                                             AlertButton(text: "Goodbye", style: .default, alertResponseType: .text(text: "Goodbye Combine!"))
                                            ])
                .sink { response in
                    switch response {
                    case .text(text: let text):
                        self.pickedWord = text
                    default: break
                    }
                }.store(in: &cancellables)
        } else {
            AlertUseCase().execute(title: title, message: message,
                                   buttons: [UIAlertAction.init(title: "Hello", style: .default, handler: { _ in
                self.pickedWord = "Hello Closure!"
            }),
                                             UIAlertAction.init(title: "Goodbye", style: .default, handler: { _ in
                self.pickedWord = "Goodbye Closure!"
            }),
                                            ])
        }
    }
}
