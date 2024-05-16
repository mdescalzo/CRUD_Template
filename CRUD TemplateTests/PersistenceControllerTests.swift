//
//  PersistenceControllerTests.swift
//  CRUD TemplateTests
//
//  Created by Mark Descalzo on 5/16/24.
//

import XCTest
import CoreData
@testable import CRUD_Template

class PersistenceControllerTests: XCTestCase {
  
  var persistenceController: PersistenceController!
  
  
  override func setUp() {
    super.setUp()
    
    persistenceController = PersistenceController(inMemory: true)
  }
  
  override func tearDown() {
    persistenceController = nil
    
    super.tearDown()
  }
  
  // Test Initialization with Persistent Store
  func testPersistentStoreInitialization() {
    let controller = PersistenceController()
    XCTAssertNotNil(controller.container)
  }
  
  // Test Initialization with In-Memory Store
  func testInMemoryStoreInitialization() {
    XCTAssertNotNil(persistenceController.container)
    XCTAssertEqual(persistenceController.container.persistentStoreDescriptions.first!.url, URL(fileURLWithPath: "/dev/null"))
  }
  
  // Test Preview Environment Setup
  func testPreviewEnvironmentSetup() {
    let previewController = PersistenceController.preview
    let viewContext = previewController.container.viewContext
    let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
    
    do {
      let items = try viewContext.fetch(fetchRequest)
      XCTAssertEqual(items.count, 10)
      for item in items {
        XCTAssertNotNil(item.id)
        XCTAssertNotNil(item.timestamp)
        XCTAssertEqual(item.title, "Sample Item")
        XCTAssertEqual(item.descriptionText, "This is the sample description text for the preview Item.")
        XCTAssertEqual(item.completed, false)
        XCTAssertEqual(item.priority, 2)
      }
    } catch {
      XCTFail("Failed to fetch items from preview environment: \(error)")
    }
  }
  
  // Test Persistent Store Loading Error Handling
  func testPersistentStoreLoadingErrorHandling() {
      class MockPersistentContainer: NSPersistentContainer {
          override func loadPersistentStores(completionHandler block: @escaping (NSPersistentStoreDescription, Error?) -> Void) {
              block(self.persistentStoreDescriptions.first!, NSError(domain: "Test", code: 9999, userInfo: nil))
          }
      }
      
      let mockContainer = MockPersistentContainer(name: "CRUD_Template")
      let expectation = self.expectation(description: "Error handling")
      
      let _ = PersistenceController(container: mockContainer)
      
      mockContainer.loadPersistentStores { (storeDescription, error) in
          XCTAssertNotNil(error)
          XCTAssertEqual((error as NSError?)?.domain, "Test")
          expectation.fulfill()
      }
      
      waitForExpectations(timeout: 1, handler: nil)
  }
  
  // Test Automatic Context Merging
  func testAutomaticContextMerging() {
    XCTAssertTrue(persistenceController.container.viewContext.automaticallyMergesChangesFromParent)
  }
  
}
