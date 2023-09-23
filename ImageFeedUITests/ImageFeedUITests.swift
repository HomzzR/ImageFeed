//
//  ImageFeedUITests.swift
//  ImageFeedUITests
//
//  Created by Артем Калюжин on 23.09.2023.
//

import XCTest

class ImageFeedUITests: XCTestCase {
    private let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app.launch()
    }
    
    func testAuth() throws {
        app.buttons["Authenticate"].tap()
        
        let webView = app.webViews["UnsplashWebView"]
        
        XCTAssertTrue(webView.waitForExistence(timeout: 7))

        let loginTextField = webView.descendants(matching: .textField).element
        XCTAssertTrue(loginTextField.waitForExistence(timeout: 6))
        
        loginTextField.tap()
        loginTextField.typeText("homzzr@yandex.ru")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        let passwordTextField = webView.descendants(matching: .secureTextField).element
        XCTAssertTrue(passwordTextField.waitForExistence(timeout: 6))
        
        passwordTextField.tap()
        passwordTextField.typeText("Marsiane123#q1")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        let loginButton = webView.descendants(matching: .button).element
        loginButton.tap()
        
        let tablesQuery = app.tables
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        
        XCTAssertTrue(cell.waitForExistence(timeout: 7))
        print(app.debugDescription)
    }
    
    func testFeed() throws {
        let tablesQuery = app.tables
        
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        tablesQuery.element.swipeUp()
        
        sleep(5)
        
        let firstCell = tablesQuery.cells.element(boundBy: 0)
        
        let likeButton = firstCell.buttons["LikeButton"]
        likeButton.tap()
        sleep(5)
        likeButton.tap()
        sleep(5)
        firstCell.tap()
        sleep(2)
        let image = app.scrollViews.images.element(boundBy: 0)

        image.pinch(withScale: 3, velocity: 1)

        image.pinch(withScale: 0.5, velocity: -1)
        
        let navBackButtonWhiteButton = app.buttons["BackButton"]
        navBackButtonWhiteButton.tap()
    }
    
    func testProfile() throws {
        sleep(3)
        
        app.tabBars.buttons.element(boundBy: 1).tap()
        
        let nameLabel = app.staticTexts["NameLabel"]
        let loginNameLabel = app.staticTexts["LoginNameLabel"]
        
        XCTAssertTrue(nameLabel.waitForExistence(timeout: 5))
        XCTAssertTrue(loginNameLabel.waitForExistence(timeout: 5))
        
        let logoutButton = app.buttons["LogoutButton"]
        logoutButton.tap()
        
        sleep(2)
        
        app.alerts["Пока, пока!"].scrollViews.otherElements.buttons["Да"].tap()
        
        sleep(2)
        
        XCTAssertTrue(app.staticTexts["Войти"].exists)
    }
}
