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
    
    func pickDuoWord(isUsingCombine:Bool = true) {
        let titleFirstAlert = "Pick a first word"
        let titleSecondAlert = "Pick a second word"
        
        if isUsingCombine {
            AlertUseCase().execute(title: titleFirstAlert, message: nil,
                                   buttons: [AlertButton(text: "Hello", style: .default, alertResponseType: .text(text: "Hello")),
                                             AlertButton(text: "Goodbye", style: .default, alertResponseType: .text(text: "Goodbye"))
                                            ])
                .sink { responseA in
                    AlertUseCase().execute(title: titleSecondAlert, message: nil,
                                           buttons: [AlertButton(text: "Combine!", style: .default, alertResponseType: .text(text: "Combine!")),
                                                     AlertButton(text: "Closure!", style: .default, alertResponseType: .text(text: "Closure!"))
                                                    ])
                        .sink { responseB in
                            var firstWord: String = ""
                            var secondWord: String = ""
                            
                            switch responseA {
                            case .text(text: let text):
                                firstWord = text
                            default: break
                            }
                            
                            switch responseB {
                            case .text(text: let text):
                                secondWord = text
                            default: break
                            }
                            
                            self.pickedWord = "\(firstWord) \(secondWord)"
                        }.store(in: &self.cancellables)
                }.store(in: &self.cancellables)
        } else {
            var firstWord = ""
            var secondWord = ""
            AlertUseCase().execute(title: titleFirstAlert, message: nil,
                                   buttons: [UIAlertAction.init(title: "Hello", style: .default, handler: { _ in
                firstWord = "Hello"
                AlertUseCase().execute(title: titleSecondAlert, message: nil,
                                       buttons: [UIAlertAction.init(title: "Combine!", style: .default, handler: { _ in
                    secondWord = "Combine!"
                    self.pickedWord = "\(firstWord) \(secondWord)"
                }),
                                                 UIAlertAction.init(title: "Closure!", style: .default, handler: { _ in
                    secondWord = "Closure!"
                    self.pickedWord = "\(firstWord) \(secondWord)"
                })
                                                ])
            }),
                                             UIAlertAction.init(title: "Goodbye", style: .default, handler: { _ in
                firstWord = "Goodbye"
                AlertUseCase().execute(title: titleSecondAlert, message: nil,
                                       buttons: [UIAlertAction.init(title: "Combine!", style: .default, handler: { _ in
                    secondWord = "Combine!"
                    self.pickedWord = "\(firstWord) \(secondWord)"
                }),
                                                 UIAlertAction.init(title: "Closure!", style: .default, handler: { _ in
                    secondWord = "Closure!"
                    self.pickedWord = "\(firstWord) \(secondWord)"
                })
                                                ])
            }),
                                            ])
        }
    }
}
