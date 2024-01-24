//
//  ContentView.swift
//  SwiftUI API Call + Working with JSON
//
//  Created by 양시관 on 1/24/24.
//

import SwiftUI


struct URLImage : View {
    let urlString : String
    @State var data : Data?
    var body: some View {
        Image("")
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage : uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:130,height: 70)
                .background(Color.gray)
            
            
        }else {
            Image(systemName: "video")
                .frame(width:130,height: 70)
                .background(Color.gray)
                .onAppear{
                    fetchData()
                }
        }
    }
    private func fetchData() {
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) {
        data,_,_ in
            self.data = data
        }
        task.resume()
    }
}


struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.courses, id:\.self) {
                    course in
                    HStack{
                        URLImage(urlString: course.image)
                            
                        Text(course.name)
                    }.padding(3)
                }
               
                
            }.navigationTitle("Courses")
                .onAppear{
                    viewModel.fetch()
                }
        }
    }
}

#Preview {
    ContentView()
}
