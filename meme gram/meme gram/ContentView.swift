//
//  ContentView.swift
//  meme gram
//
//  Created by Praval Gautam on 03/05/23.
import SwiftUI

struct ContentView: View {
    // Define the endpoint URL

    
    // Define the view state
    @State var images: [UIImage] = []
    
    var body: some View {
        NavigationView{
            ZStack{
              Spacer()
                VStack {
                    
                    
                    
                    if !images.isEmpty {
                        Image(uiImage: images[0])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350, height: 450)
                    } else {
                        Text("Loading...")
                        
                    }
                    Spacer()
                    Button("Next Meme") {
                        fetchData()
                    }
                   
                    
                    .frame(width: 200,height: 50)
                    .foregroundColor(.white)
                    
                    .background(LinearGradient(colors: [Color.white,Color.blue,Color.gray], startPoint: .bottom, endPoint: .top))
                    .cornerRadius(30)
                    Spacer()
                    
                }
          
                
            }
  
            .onAppear(perform: fetchData)
            .navigationTitle("MEMES")
            
        }
    }
            
            func fetchData() {
                let endpoint = URL(string: "https://meme-api.com/gimme/2")!
                // Create a URLSession instance
                
                let session = URLSession.shared
                
                // Create a data task to perform the API call
                let task = session.dataTask(with: endpoint) { data, response, error in
                    // Check for errors
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                        return
                    }
                    
                
                    // Check that data was returned
                    guard let data = data else {
                        print("Error: No data returned")
                        return
                    }
                    
                    // Parse the JSON response
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let dict = json as? [String: Any],
                           let memes = dict["memes"] as? [[String: Any]],
                           let firstMeme = memes.first,
                           let url = firstMeme["url"] as? String,
                           let imageUrl = URL(string: url),
                           let imageData = try? Data(contentsOf: imageUrl),
                           let uiImage = UIImage(data: imageData) {
                            DispatchQueue.main.async {
                                self.images = [uiImage]
                            }
                        }
                    } catch {
                        print("Error: Failed to parse JSON response")
                    }
                }
                
                // Start the data task
                task.resume()
            }
            
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
