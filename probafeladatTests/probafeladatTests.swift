//
//  probafeladatTests.swift
//  probafeladatTests
//
//  Created by Szabolcs Varga on 2019. 11. 14..
//  Copyright © 2019. WUP. All rights reserved.
//

import XCTest
import Swinject

class probafeladatTests: XCTestCase {
    private let container = Container()
    
    let dummyURLString = "https://dummy.url.com"
    var data: Data?
    var response: URLResponse?
    var error: Error?
    var cards: [Card]?
    var testJson = ""
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        data = nil
        response = nil
        error = nil
        cards = nil
        testJson = ""
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testHttpClient() {
        
        let httpClientMock = HttpClientMock(data: data, response: response, error: error)
        
        httpClientMock.get(url: URL(string: dummyURLString)!) { (data, response, error) in
            return
        }
        
        XCTAssertTrue(httpClientMock.gotCalled)
    }
    
    func testRequestGotUnauthorized() {
        
        testJson =
        "[{\"cardId\": \"1\",\"issuer\": \"Visa - Banca Monte Dei Paschi Di Siena S.P.A., Italy (Electron)\",\"cardNumber\": \"4003-1565-5402-0882\",\"expirationDate\": \"2021/12\",\"cardHolderName\": \"Mr. Shea Wiza\",\"friendlyName\": \"Personal Loan Account\",\"currency\": \"BAM\",\"cvv\": \"962\",\"availableBalance\": 60456,\"currentBalance\": 4544,\"minPayment\": 0,\"dueDate\": \"2018-09-26\",\"reservations\": 3688,\"balanceCarriedOverFromLastStatement\": 856,\"spendingsSinceLastStatement\": 3688,\"yourLastRepayment\": \"2018-09-26\",\"accountDetails\": {\"accountLimit\": 65000,\"accountNumber\": \"01-558-9\"},\"status\": \"ACTIVE\",\"cardImage\": \"1\"},{\"cardId\": \"2\",\"issuer\": \"Visa - Banca Monte Dei Paschi Di Siena S.P.A., Italy (Electron)\",\"cardNumber\": \"4003-1565-5402-0882\",\"expirationDate\": \"2021/12\",\"cardHolderName\": \"Mr. Shea Wiza\",\"friendlyName\": \"Personal Loan Account\",\"currency\": \"BAM\",\"cvv\": \"962\",\"availableBalance\": 60456,\"currentBalance\": 4544,\"minPayment\": 0,\"dueDate\": \"2018-09-26\",\"reservations\": 3688,\"balanceCarriedOverFromLastStatement\": 856,\"spendingsSinceLastStatement\": 3688,\"yourLastRepayment\": \"2018-09-26\",\"accountDetails\": {\"accountLimit\": 65000,\"accountNumber\": \"01-558-9\"},\"status\": \"ACTIVE\",\"cardImage\": \"1\"}]"
        
        
        data = Data(testJson.utf8)
        response = HTTPURLResponse(url: URL(string: dummyURLString)!, statusCode: 401, httpVersion: nil, headerFields: nil)
        error = NSError(domain: "", code: 401, userInfo: ["Unauthorized" : ""])
        
        let httpClientMock = HttpClientMock(data: data, response: response, error: error)
        let service = Service(httpClient: httpClientMock)
        service.fetchData(urlString: dummyURLString) { (fetchedCards: [Card]?, error) in
            self.cards = fetchedCards
            self.error = error
            
            XCTAssertNil(self.cards)
            XCTAssertNotNil(self.error)
        }
        
    }
    
    func testGettingCards() {
        let dataApi = DataApi(service: Service(httpClient: HttpClient()))
        dataApi.getCard { (fetchedCards, error) in
            if let cardArray = fetchedCards {
                self.cards = cardArray
            }
            
            XCTAssertNotNil(self.cards)
            XCTAssertNil(error)
        }
    }
    
    func testCardsIsNilWhenErrorOccured() {
        
        let httpClient = HttpClientMock(data: data, response: response, error: error)
        let service = Service(httpClient: httpClient)
        service.fetchData(urlString: dummyURLString) { (fetchedCards: [Card]?, error) in
            if let cardArray = fetchedCards {
                self.cards = cardArray
            }
        }
        
        XCTAssertNil(cards)
    }
    
    func testGettingCardsWithSwinject() {
        container.register(HttpClientProtocol.self) { _ in
             HttpClient()
        }
        
        container.register(ServiceProtocol.self) { r in
            Service(httpClient: r.resolve(HttpClientProtocol.self)!)
        }
        
        container.register(DataApi.self) { r in
            DataApi(service: r.resolve(ServiceProtocol.self)!)
        }
        
        let api = container.resolve(DataApi.self)!
        
        api.getCard { (cards, error) in
            self.cards = cards
            self.error = error
            
            XCTAssertNotNil(self.cards)
            XCTAssertNil(error)
        }
        
    }
    
}
