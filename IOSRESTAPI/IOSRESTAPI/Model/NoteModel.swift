//
//  NoteModel.swift
//  IOSRESTAPI
//
//  Created by mz on 07.09.23.
//

import Foundation


struct Note:Codable,Identifiable{
    
    var id:Int?
    var title:String?
    var content:String?
    var category:String?
    

    init(){
        
    }
    
    init(id: Int? = nil, title: String, content: String, category: String) {
        self.id = id
        self.title = title
        self.content = content
        self.category = category
    }
    
    
}
