//
//  ContentView.swift
//  MenuSelectorSwiftUI
//
//  Created by Cyan on 2022/05/21.
//

import SwiftUI

struct ContentView: View {
    let zones_kr = ["강남⋅서초⋅양재","분당","수지", "아주대","신촌⋅이대⋅연희","서교⋅합정⋅상수","연남⋅성산","한남⋅이태원","종로","마포","신림⋅서울대입구", "수유⋅우이"];
//    let zones = ["sector1","sector2","sector3","sector4","sector5","sector6","sector7"]
    @State private var zoneSelection = "";
    @State private var header = "¡Bienvenue à RMS!";
    @State private var headerDescription = "Random Menu Selector";
    
    var body: some View {
        VStack(spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/) {
            NavigationView {
                Form {
                    Section(header: Text("Zones")) {
                        Picker("Select", selection: $zoneSelection) {
                            ForEach(zones_kr, id: \.self){ option in
                                Text(option)
                            }
                        }
                        HStack(alignment: .lastTextBaseline) {
                            Text("Zone")
                            Text("\(zoneSelection)").frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                }.navigationBarTitleDisplayMode(.inline).toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text(header)
                                .font(.system(size: 25)).multilineTextAlignment(.center);
                            Text(headerDescription).font(.system(size: 10)).multilineTextAlignment(.trailing);
                        }
                    }
                }
        }
            Divider()
        BuildGetButton();
    }

        
//    func TitleView() -> some View {
//        let titleView = HStack(alignment: .top, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/) {
//            VStack(alignment: .center) {
//                Text(header)
//                    .font(.system(size: 25)).multilineTextAlignment(.center);
//                Text(headerDescription)
//                    .font(.system(size: 10)).multilineTextAlignment(.center);
//            }.multilineTextAlignment(.center)
//        }
//        return titleView;
//    }
    }
    func BuildGetButton() -> some View {
        let getBT = Button(action: {
            // TODO : C++ RNG to return a result
            // emulate the result on GUI
            print("Button Pressed")
        }){
            Text("Give me one")
                .padding()
                .font(.headline.bold())
                .foregroundColor(.white)
                .background(Color(red: 5/225, green: 168/225, blue: 228/225));
        }
        return getBT;
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
