//
//  WebViewPresenter.swift
//  ImageFeed
//
//  Created by Артем Калюжин on 23.09.2023.
//

import UIKit
import WebKit

// MARK: - Protocol
public protocol WebViewPresenterProtocol {
    var view: WebViewViewControllerProtocol? { get set }
    func viewDidLoad()
    func didUpdateProgressValue(_ newValue: Double)
    func code(from url: URL) -> String?
}

final class WebViewPresenter: WebViewPresenterProtocol {
    // MARK: - Properties
    
    weak var view: WebViewViewControllerProtocol?
    var authHelper: AuthHelperProtocol
    init(authHelper: AuthHelperProtocol) {
        self.authHelper = authHelper
    }
    
    // MARK: - Functions
    func viewDidLoad() {
        let request = authHelper.authRequest()
        didUpdateProgressValue(0)
        view?.load(request: request)
    }
    
    func didUpdateProgressValue(_ newValue: Double) {
            let newProgressValue = Float(newValue)
            view?.setProgressValue(newProgressValue)
            
            let shouldHideProgress = shouldHideProgress(for: newProgressValue)
            view?.setProgressHidden(shouldHideProgress)
        }
        
    func shouldHideProgress(for value: Float) -> Bool {
            abs(value - 1.0) <= 0.0001
        }
    
    func code(from url: URL) -> String? {
        authHelper.code(from: url)
    }
}
