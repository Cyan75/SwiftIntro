//
//  ContentView.swift
//  MenuSelectorSwiftUI
//
//  Created by Cyan on 2022/05/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        VStack{
//            Form{
//                Group{
//                    Section(header: Text("Zones")){
//                        Picker(selection: .constant(1), label: Text("Picker")) {
//                            Text("1").tag(1)
//                            Text("2").tag(2)
//                            Text("3").tag(3)
//                            Text("4").tag(4)
//                        }
//                    }
//                }
//                Text("Hullo World").font(.system(size: 25))
//            }
//        }
        VStack {
            Text("Press the button below")
                .font(.system(size: 25))
            
            Button(action: {
                print("Button is pressed")
            }) {
                Text("Press me")
                    .padding()
                    .font(.body)
                    .foregroundColor(.white)
                    .background(Color.blue)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
