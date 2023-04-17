//
//  CoreDataManager.swift
//  movieNote
//
//  Created by 이주상 on 2023/03/20.
//

import UIKit
import CoreData

protocol CoreDataManagerProtocol {
    func getMovieNotesFromeCoreData() -> [MovieNoteData]
    func isSavedMovieNote(with movieTitle: String) -> Bool
    func setMovieNote(with movie: Movie, contents: String)
    func deleteMovieNote(with movieNote: MovieNoteData, completion: @escaping () -> Void)
    func updateMovieNote(with movieNote: MovieNoteData, completion: @escaping () -> Void)
}

final class CoreDataManager: CoreDataManagerProtocol {
    
    static let shared = CoreDataManager()
    private init() {}
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let entityName = "MovieNoteData"
    
    func getMovieNotesFromeCoreData() -> [MovieNoteData] {
        var savedMovies: [MovieNoteData] = []
        // 임시저장소 있는지 확인
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.entityName)
            let savedDate = NSSortDescriptor(key: "savedDate", ascending: true)
            request.sortDescriptors = [savedDate]
            
            do {
                // 임시저장소에서 (요청서를 통해서) 데이터 가져오기
                if let fetchedMovies = try context.fetch(request) as? [MovieNoteData] {
                    savedMovies = fetchedMovies
                }
            } catch {
                print("movieNote 로드 실패")
            }
        }

        return savedMovies
    }
    // movieNote가 db에 저장되어 있는지 확인하는 함수
    func isSavedMovieNote(with movieTitle: String) -> Bool {
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.entityName)
            request.predicate = NSPredicate(format: "title = %@", movieTitle as String)
            
            do {
                if let fetchedMovieNotes = try context.fetch(request) as? [MovieNoteData] {

                    if fetchedMovieNotes.first(where: {
                        $0.title == movieTitle
                    }) != nil {
                        return true
                    }
                }
            } catch {
                print("movieNote 삭제 실패")
            }
        }
        return false
    }
    
    func setMovieNote(with movie: Movie, contents: String) {
        if let context = context {
           
            if let entity = NSEntityDescription.entity(forEntityName: self.entityName, in: context) {
                
                if let movieNoteData = NSManagedObject(entity: entity, insertInto: context) as? MovieNoteData {
                    
                    movieNoteData.jpegData = movie.jpegData
                    movieNoteData.title = movie.title.htmlToString
                    movieNoteData.imageURL = movie.imageURL
                    movieNoteData.pubDate = movie.pubDate
                    movieNoteData.savedDate = Date()
                    movieNoteData.contents = contents
                   
                    if context.hasChanges {
                        do {
                            try context.save()
                        } catch {
                            print(error)
                        }
                    }
                }
            }
        }
    }
    
    func deleteMovieNote(with movieNote: MovieNoteData, completion: @escaping () -> Void) {
        guard let savedDate = movieNote.savedDate else {
            completion()
            return
        }
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.entityName)
            request.predicate = NSPredicate(format: "savedDate = %@", savedDate as CVarArg)
            
            do {
                if let fetchedMovieNotes = try context.fetch(request) as? [MovieNoteData] {
                    if let targetMovie = fetchedMovieNotes.first {
                        context.delete(targetMovie)
 
                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("movieNote 삭제 실패")
                completion()
            }
        }
    }
    
    func updateMovieNote(with movieNote: MovieNoteData, completion: @escaping () -> Void) {
        
        guard let savedDate = movieNote.savedDate else {
            completion()
            return
        }
        
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.entityName)
            request.predicate = NSPredicate(format: "savedDate = %@", savedDate as CVarArg)
            
            do {
                if let fetchedMovieNotes = try context.fetch(request) as? [MovieNoteData] {
                    if var targetMovieNote = fetchedMovieNotes.first {
                        
                        targetMovieNote = movieNote
                        
                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("movieNote 수정 실패")
                completion()
            }
        }
    }
}
