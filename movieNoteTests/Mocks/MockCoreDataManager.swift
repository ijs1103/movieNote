//
//  MockCoreDataManager.swift
//  movieNoteTests
//
//  Created by 이주상 on 2023/03/27.
//

import Foundation
@testable import movieNote

final class MockCoreDataManager: CoreDataManagerProtocol {
    
    var movieNotes: [MovieNoteData] = []
    
    var isCalledGetMovieNotesFromeCoreData = false
    var isCalledIsSavedMovieNote = false
    var isCalledSetMovieNote = false
    var isCalledDeleteMovieNote = false
    var isCalledUpdateMovieNote = false
    
    func getMovieNotesFromeCoreData() -> [MovieNoteData] {
        isCalledGetMovieNotesFromeCoreData = true
        return movieNotes
    }
    
    func isSavedMovieNote(with movieTitle: String) -> Bool {
        isCalledIsSavedMovieNote = true
        return true
    }
    
    func setMovieNote(with movie: Movie, contents: String) {
        isCalledSetMovieNote = true
    }
    
    func deleteMovieNote(with movieNote: MovieNoteData, completion: @escaping () -> Void) {
        isCalledDeleteMovieNote = false
    }
    
    func updateMovieNote(with movieNote: MovieNoteData, completion: @escaping () -> Void) {
        isCalledUpdateMovieNote = false
    }
}
