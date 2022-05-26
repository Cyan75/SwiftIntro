//
//  ContentView.swift
//  MenuSelectorSwiftUI
//
//  Created by Cyan on 2022/05/21.
//

import SwiftUI

struct ContentView: View {
    let zones_kr = ["강남⋅서초⋅양재","분당","수지", "아주대","신촌⋅이대⋅연희","서교⋅합정⋅상수","연남⋅성산","한남","종로","마포","신림⋅서울대입구", "수유⋅우이"];
    let zones = ["sector1","sector2","sector3","sector4","sector5","sector6","sector7"]
    @State var zoneSelection = "";
    var body: some View {
        VStack {
            Text("Bienvenue à RMS")
                .font(.system(size: 25)).multilineTextAlignment(.center);
            Text("Random Menu Selector ")
                .font(.system(size: 10)).multilineTextAlignment(.center);
            
            Button(action: {
                print("Button is pressed")
            }) {
                Text("Press me")
                    .padding()
                    .font(.headline.bold())
                    .foregroundColor(.white)
                    .background(Color(red: 0.4627, green: 0.8392, blue: 1.0));
            }/*.frame(maxWidth : .infinity)*/
            NavigationView{
                Form{
                    Group{
                        Section(header: Text("Zones")){
                            Picker("Select", selection: $zoneSelection){
                                ForEach(zones, id: \.self){ option in
                                    Text(option)
                                }
                            }
                            Text("Zone") + Text("\t\t\(zoneSelection)").;
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
