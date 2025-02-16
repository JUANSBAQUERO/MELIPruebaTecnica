//
//  SearchViewUITests.swift
//  meli
//
//  Created by Juan  on 16/02/25.
//

import XCTest

final class SearchViewUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testSearchFunctionality() throws {
        let searchField = app.textFields["Buscar productos..."]
        XCTAssertTrue(searchField.exists, "El campo de búsqueda no está presente")
        
        searchField.tap()
        searchField.typeText("iPhone")
        
        let searchButton = app.buttons["magnifyingglass"]
        XCTAssertTrue(searchButton.exists, "El botón de búsqueda no está presente")
        searchButton.tap()
        
        let firstResult = app.staticTexts.element(boundBy: 0)
        XCTAssertTrue(firstResult.waitForExistence(timeout: 5), "No se encontraron resultados después de la búsqueda")
    }
    
    func testNoResultsView() throws {
        let searchField = app.textFields["Buscar productos..."]
        searchField.tap()
        searchField.typeText("ProductoInexistente123")
        
        let searchButton = app.buttons["magnifyingglass"]
        searchButton.tap()
        
        let noResultsText = app.staticTexts["No se encontraron resultados"]
        XCTAssertTrue(noResultsText.waitForExistence(timeout: 5), "El mensaje de 'No se encontraron resultados' no apareció")
    }
}
