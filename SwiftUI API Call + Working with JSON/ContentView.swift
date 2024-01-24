//
//  ContentView.swift
//  SwiftUI API Call + Working with JSON
//
//  Created by 양시관 on 1/24/24.
//

import SwiftUI

struct Course: Hashable, Codable {
    let name : String
    let image: String
    
}


class ViewModel : ObservableObject {
    @Published var courses : [Course] = []
    
    func fetch() {
        guard let url = URL(string:
                                "https://iosacademy.io/api/v1/courses/index.php") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self]
            data,_,error in
            guard let data = data, error == nil else {
                return
            }
            
            //TODO: - convert api
            
            do {
                let courses = try JSONDecoder().decode([Course].self,from: data)
                DispatchQueue.main.async {
                    self?.courses = courses
                }
            }catch {
                print(error)
            }
        }
    }
}




struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                
              Text("df")
                
            }.navigationTitle("Courses")
        }
    }
}

#Preview {
    ContentView()
}
