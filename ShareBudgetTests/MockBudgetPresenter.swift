//
//  MockBudgetPresenter.swift
//  ShareBudget
//
//  Created by Denys Meloshyn on 18.05.17.
//  Copyright © 2017 Denys Meloshyn. All rights reserved.
//
import UIKit
@testable import ShareBudget

class MockBudgetPresenter: BudgetPresenter {
    var calledMethods = [String: Any]()
}