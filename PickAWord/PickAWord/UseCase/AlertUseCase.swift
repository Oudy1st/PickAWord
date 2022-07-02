//
//  AlertUseCase.swift
//  PickAWord
//
//  Created by Detchat Boonpragob on 2/7/2565 BE.
//

import Foundation
import Combine
import UIKit

public enum AlertResponseType {
    case ok, cancel, text(text:String)
}

public struct AlertButton {
    var text: String
    var style: UIAlertAction.Style
    var alertResponseType: AlertResponseType
    
    internal init(text: String, style: UIAlertAction.Style, alertResponseType: AlertResponseType) {
        self.text = text
        self.style = style
        self.alertResponseType = alertResponseType
    }
}

public class AlertUseCase {
    public func execute(title:String, message:String?, buttons:[UIAlertAction]) {
        let alertC = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        buttons.forEach({ alertC.addAction($0) })

        getTopViewController()?.present(alertC, animated: true, completion: nil)
    }
    
    public func execute(title:String, message:String?, buttons:[AlertButton]) -> AnyPublisher<AlertResponseType, Never> {
        return Future<AlertResponseType, Never> { promise in
                let alertC = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
                for button in buttons {
                    alertC.addAction(.init(title: button.text, style: button.style, handler: { _ in
                        promise(.success(button.alertResponseType))
                    }))
                }
                self.getTopViewController()?.present(alertC, animated: true, completion: nil)
            }
            .flatMap { response -> AnyPublisher<AlertResponseType, Never> in
                return Just(response).eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
    
    private func getTopViewController() -> UIViewController? {
        let window = UIApplication.shared.connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }
        return window?.rootViewController
    }
    
}
