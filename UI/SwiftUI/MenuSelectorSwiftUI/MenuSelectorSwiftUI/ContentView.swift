//
//  ContentView.swift
//  MenuSelectorSwiftUI
//
//  Created by Cyan on 2022/05/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        Text("Select Zone")
//            .multilineTextAlignment(.center)
//            .padding()
        Picker(selection: .constant(1), label: Text("Picker")) {
            Text("1").tag(1)
            Text("2").tag(2)
            Text("3").tag(3)
            Text("4").tag(4)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Form{
            Group{
                Section(header: Text("Zones")){
                    HStack{
                        
                    }
                    ContentView()
                }
            }
        }
            
    }
}
