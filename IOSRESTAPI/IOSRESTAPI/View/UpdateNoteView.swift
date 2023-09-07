//
//  UpdateNoteView.swift
//  IOSRESTAPI
//
//  Created by mz on 07.09.23.
//

import SwiftUI

struct UpdateNoteView: View {
    @ObservedObject var noteViewController = NoteViewController()
    var object: Note
    
    @State private var title = ""
    @State private var content = ""
    @State private var category = ""
    
    

    var body: some View {
        
        NavigationView{
            List{
                Section{
                    TextField(object.title!,text: $title)
                    TextField(object.content!,text: $content)
                    TextField(object.category!,text: $category)
                }header: {
                    Text("Create new Note")
                }
                
                Button(action: {
                    if title.isEmpty {
                        title = object.title!
                    }
                    if content.isEmpty {
                        content = object.content!
                    }
                    if category.isEmpty {
                        category = object.category!
                    }
                    let updateNote = Note(id:object.id,title: title, content: content, category: category)
                    noteViewController.updateNote(updateNote: updateNote)
                }){
                    Text("Submit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.green)
                        .cornerRadius(15.0)
                }
            }
        }
       
    }
}

#Preview {
    UpdateNoteView(object: Note())
}
