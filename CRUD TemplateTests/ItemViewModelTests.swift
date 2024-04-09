//
//  ItemViewModelTests.swift
//  CRUD TemplateTests
//
//  Created by Mark Descalzo on 4/9/24.
//

import XCTest
import CoreData
@testable import CRUD_Template

class ItemViewModelTests: XCTestCase {
    var persistentContainer: NSPersistentContainer!
    var viewContext: NSManagedObjectContext!

    override func setUp() {
        super.setUp()
        
        // Initialize the in-memory persistent container
        persistentContainer = NSPersistentContainer(name: "CRUD_Template")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        persistentContainer.persistentStoreDescriptions = [description]
        
        persistentContainer.loadPersistentStores { (description, error) in
            XCTAssertNil(error)
        }
        
        viewContext = persistentContainer.viewContext
    }

    override func tearDown() {
        persistentContainer = nil
        viewContext = nil
        
        super.tearDown()
    }

    func testLoadItemData() {
        let item = createSampleItem()
        let viewModel = ItemViewModel(item: item, context: viewContext)
        
        XCTAssertEqual(viewModel.title, "Sample Title")
        XCTAssertEqual(viewModel.descriptionText, "Sample Description")
        XCTAssertEqual(viewModel.completed, true)
        XCTAssertEqual(viewModel.priority, 1)
        XCTAssertNotNil(viewModel.timestamp)
    }

    func testSaveChanges() {
        let item = createSampleItem()
        let viewModel = ItemViewModel(item: item, context: viewContext)
        
        viewModel.title = "Updated Title"
        viewModel.saveChanges()
        
        XCTAssertEqual(item.title, "Updated Title")
    }

    func testDiscardChanges() {
        let item = createSampleItem()
        let viewModel = ItemViewModel(item: item, context: viewContext)
        
        viewModel.title = "Temporary Title"
        viewModel.discardChanges()
        
        XCTAssertEqual(viewModel.title, "Sample Title")
    }

    func testDiscardSelf() {
        let item = createSampleItem()
        let viewModel = ItemViewModel(item: item, context: viewContext)
        
        viewModel.discardSelf()
        
        XCTAssertTrue(item.isDeleted)
    }
    
    private func createSampleItem() -> Item {
        let item = Item(context: viewContext)
        item.title = "Sample Title"
        item.descriptionText = "Sample Description"
        item.completed = true
        item.priority = 1
        item.timestamp = Date()
        
        return item
    }
}
