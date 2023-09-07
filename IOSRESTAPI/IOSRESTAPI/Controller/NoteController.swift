//
//  NoteController.swift
//  IOSRESTAPI
//
//  Created by mz on 07.09.23.
//

import Foundation

class NoteViewController:ObservableObject{
    
    @Published var listNotes:[Note] = []
    @Published var createNote : Note?
    @Published var updateNote : Note?
    @Published var deletedNoteId :Int?
    
    let prefixUrl = "http://127.0.0.1:5000"
    
    
    //MARK: - fetch note Endpoint
    func fetchNote(){
        guard let url = URL(string: "\(prefixUrl)/note/get") else {
            return
        }
        URLSession.shared.dataTask(with: url) {data, response, error in
            
            if let error = error {
                print("Error fetching notes: \(error)")
            }
            
            if let data = data{
                do{
                    let notes = try JSONDecoder().decode([Note].self, from: data)
                    DispatchQueue.main.async {
                        self.listNotes = notes
                    }
                } catch{
                    print("Error decoding notes: \(error)")
                }
            }
            
        }.resume()
        
    }
    
    
    //MARK: - POST note Endpoint
    func createNote(newNote:Note){
        guard let url = URL(string: "\(prefixUrl)/note/create") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do{
            let requestData = try JSONEncoder().encode(newNote)
            request.httpBody = requestData
        } catch{
            print("Erro Encoder newNote: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            
            if let error = error {
                print("Error fetching notes: \(error)")
            }
            
            if let data = data{
                do{
                    let createdNote = try JSONDecoder().decode(Note.self, from: data)
                    DispatchQueue.main.async {
                        self.createNote = createdNote
                        self.fetchNote()
                    }
                } catch{
                    print("Error decoding notes: \(error)")
                }
            }
            
        }.resume()
        
    }
    
    //MARK: - Delete note Endpoint
    func deleteNote(noteId: Int) {
        guard let url = URL(string: "\(prefixUrl)/note/delete/\(noteId)") else {
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                print("Error deleting task: \(error)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 204 {
                DispatchQueue.main.async {
                    self.deletedNoteId = noteId
                    self.fetchNote()
                }
            }
        }
        .resume()
    }
    
    
    
    //MARK: - Update note Endpoint
    func updateNote(updateNote: Note) {
        guard let url = URL(string: "\(prefixUrl)/note/update/\(updateNote.id!)") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do{
            let requestData = try JSONEncoder().encode(updateNote)
            request.httpBody = requestData
        } catch{
            print("Erro Encoder newNote: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data , response, error in
            if let error = error {
                print("Error deleting task: \(error)")
                return
            }
            
            if let data = data{
                do{
                    let updatedNote = try JSONDecoder().decode(Note.self, from: data)
                    DispatchQueue.main.async {
                        self.updateNote = updatedNote
                    }
                } catch{
                    print("Error decoding notes: \(error)")
                }
            }
        }
        .resume()
    }
    
} // End of class
