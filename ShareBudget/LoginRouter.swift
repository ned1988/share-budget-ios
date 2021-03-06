//
//  LoginRouter.swift
//  ShareBudget
//
//  Created by Denys Meloshyn on 16.01.17.
//  Copyright © 2017 Denys Meloshyn. All rights reserved.
//

import UIKit

protocol LoginRouterProtocol {
    func showHomePage()
}

class LoginRouter: BaseRouter, LoginRouterProtocol {
    func showHomePage() {
        let loginViewController = viewController?.storyboard?.instantiateInitialViewController()
        UIApplication.shared.delegate?.window??.rootViewController = loginViewController
    }
}
