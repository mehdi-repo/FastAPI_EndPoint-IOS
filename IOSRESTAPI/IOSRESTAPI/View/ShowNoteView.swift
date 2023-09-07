//
//  ShowNoteView.swift
//  IOSRESTAPI
//
//  Created by mz on 07.09.23.
//

import SwiftUI

struct ShowNoteView: View {
    
    @ObservedObject var noteViewController = NoteViewController()
    @State private var isPresentCreateNote = false
    
    
    var body: some View {
        
        NavigationStack{
            List {
                ForEach(noteViewController.listNotes, id: \.id) { note in
                    
                    NavigationLink(destination: UpdateNoteView(object: note)) {
                        HStack() {
                            Image(systemName: "note")
                                .frame(width:50,height: 30)
                            Text(note.title!)
                            Spacer()
                        }
                    }
                }
                // MARK: - End of forEach
                

                .onDelete( perform: { indexSet in
                    let retrievedItems = indexSet.map { noteViewController.listNotes[$0].id }
                    let optionalValue: Int? = retrievedItems.first!
                    if let unwrappedValue = optionalValue {
                        let noteId: Int = unwrappedValue
                        noteViewController.listNotes.remove(atOffsets: indexSet)
                        noteViewController.deleteNote(noteId: noteId)
                        
                    } else {
                        print("The optional value is nil.")
                    }
                })
                .onDisappear{
                    noteViewController.fetchNote()
                }
                
                
            }
            // MARK: - End of List
            .onAppear{
                noteViewController.fetchNote()
            }
            .listStyle(.inset)
            
            .navigationTitle("Note List")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        isPresentCreateNote.toggle()
                    } label: {
                        Label("Add Note",systemImage: "plus.circle")
                    }
                }
            }
        }
        //MARK: - End of Navigation
        .sheet(isPresented: $isPresentCreateNote, content: {
            CreateNoteView()
                .onAppear{
                    noteViewController.fetchNote()
                }
                .onDisappear{
                    noteViewController.fetchNote()
                }
        })
        
    }
}

#Preview {
    ShowNoteView()
}
