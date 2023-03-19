//
//  APIDemoUIView.swift
//  demo
//
//  Created by Ankush on 13/02/23.
//

import SwiftUI

struct APIDemoUIView: View {
    
    //StateObject for first time -> INIT/First time loading
    //Obserable Object -> Innerviews
    @StateObject var viewModelObj: APIRequestViewModel = APIRequestViewModel()
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                List {
                    
                    if viewModelObj.isLoading {
                        ProgressView()
                    } else {
                        if let data = viewModelObj.homeObj?.data {
                            ForEach (data , id: \.self) { book in
                                
                                var str = "\(book.nation) has population of \(book.population) in year \(book.year)."
                                
                                NavigationLink {
                                    
                                    let diff = viewModelObj.homeObj?.data!
                                        .filter({ currentObject in
                                            if currentObject == book {
                                                str = "\(currentObject.nation) has population of \(currentObject.population) in year \(currentObject.year)."
                                            }
                                            return currentObject == book
                                        })
                                    
                                    var index = viewModelObj.homeObj?.data?.firstIndex(of: (diff?.first)!)
                                    
                                    CountryDetailView(viewModelObj: self.viewModelObj, objIndex: index ?? 0, showGreeting: book.isSelected)
                                } label: {
                                    HStack {
                                        Text(str)
                                            .padding(.all)
                                            .foregroundColor(.white)
                                            .background(book.isSelected ? .red : .gray)
                                            .cornerRadius(12.0)
                                    }
                                }
                                
                            }
                        }
                    }
                    
                }.navigationTitle("Book List")
            }
        }
    }
}

struct APIDemoUIView_Previews: PreviewProvider {
    static var previews: some View {
        APIDemoUIView()
    }
}
