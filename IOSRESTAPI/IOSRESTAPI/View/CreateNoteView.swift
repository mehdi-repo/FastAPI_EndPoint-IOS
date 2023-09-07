//
//  CreateNoteView.swift
//  IOSRESTAPI
//
//  Created by mz on 07.09.23.
//

import SwiftUI

struct CreateNoteView: View {
    
    @ObservedObject var noteViewController = NoteViewController()
    @State private var note : Note? = nil
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var content = ""
    @State private var category = ""
    
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    TextField("Title",text: $title)
                    TextField("Content",text: $content)
                    TextField("Category",text: $category)
                }header: {
                    Text("Create new Note")
                }
                
                Button(action: {
                    let newNote = Note(title: title, content: content, category: category)
                    noteViewController.createNote(newNote: newNote)
                    dismiss()
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
    CreateNoteView()
}
