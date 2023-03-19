//
//  CountryDetailView.swift
//  demo
//
//  Created by Ankush on 13/02/23.
//

import SwiftUI

struct CountryDetailView: View {
    
    @Environment(\.presentationMode) var presepentedMode
    @ObservedObject var viewModelObj: APIRequestViewModel
    
    @State var objIndex: Int
    @State var showGreeting: Bool
    
    var body: some View {
        VStack {
            
            let currentObject = self.setData()
            
            var str = currentObject
           
            
            Image(systemName: "star")
                .resizable()
                .frame(width: 60, height: 60)
                .padding(.all)
            Text(str)
                .padding(.all)
                .font(.title2)
            
            Toggle(isOn: $showGreeting) {
                Text("Is selected")
            }.onChange(of: showGreeting) { newValue in
                
                viewModelObj.homeObj?.data?[objIndex].isSelected = newValue
            }.padding(.all)
            
            
            Button {
                self.presepentedMode.wrappedValue.dismiss()
            } label: {
                Text("GO BACK")
            }.padding(.all)
                .font(.largeTitle)
            
        }
    }
    
    func setData() -> String {
        if let currentObject = viewModelObj.homeObj?.data?[objIndex] {
            return "\(currentObject.nation) has population of \(currentObject.population) in year \(currentObject.year)."
        }
        return ""
    }
}

struct CountryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetailView(viewModelObj: APIRequestViewModel(), objIndex: 0 ,showGreeting: false)
    }
}
