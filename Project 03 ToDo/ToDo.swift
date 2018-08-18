//
//  ToDo.swift
//  Project 03 ToDo
//
//  Created by Chris on 18/8/2018.
//  Copyright © 2018 Chris. All rights reserved.
//

import Foundation

struct ToDo: Equatable {
    var title: String
    var date: Date
    var category: Category
    
    init(title: String, date: Date, category: Category){
        self.init()
        self.title = title
        self.date = date
        self.category = category
    }
    
    init() {
        title = "Untitled To Do"
        date = Date()
        category = .work
    }
    
    static func ==(lhs: ToDo, rhs: ToDo) -> Bool{
        return lhs.title == rhs.title && lhs.date == rhs.date && lhs.category == rhs.category
    }
    
    enum Category {
        case work
        case money
        case food
        case people
        case shopping
        
        func image() -> String {
            switch self {
            case .work:
                return "work"
            case .money:
                return "money"
            case .food:
                return "food"
            case .people:
                return "people"
            case .shopping:
                return "shopping"
            }
        }
    }
}
