//
//  BLEScan.swift
//  LazherMeApp
//
//  Created by theo on 12/04/2022.
//

import SwiftUI
 
struct BLEScan: View {
    
    @ObservedObject var bleManager = BLEManager()
 
    var body: some View {
        VStack (spacing: 10) {
 
            Text("Appareils Bluetooth")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .center)
            List(bleManager.peripherals) { peripheral in
                HStack {
                    Text(peripheral.name)
                    Spacer()
                    Text(String(peripheral.rssi))
                }
            }.frame(height: 300)
 
            Spacer()
 
            Text("STATUS")
                .font(.headline)
 
            // Status goes here
            if bleManager.isSwitchedOn {
                Text("Le BLuetooth est activé")
                    .foregroundColor(.green)
            }
            else {
                Text("Le Bluetooth n'est PAS activé")
                    .foregroundColor(.red)
            }
 
            Spacer()
 
            HStack {
                VStack (spacing: 10) {
                    Button(action: {
                        self.bleManager.startScanning()
                    }) {
                        Text("Scanner")
                    }
                    Button(action: {
                        self.bleManager.stopScanning()
                    }) {
                        Text("Arreter de scanner")
                    }
                }.padding()
 
                Spacer()
 
                VStack (spacing: 10) {
                    Button(action: {
                        print("Start Advertising")
                    }) {
                        Text("Start Advertising")
                    }
                    Button(action: {
                        print("Stop Advertising")
                    }) {
                        Text("Stop Advertising")
                    }
                }.padding()
            }
            Spacer()
        }
    }
}
 
struct BLEScan_Previews: PreviewProvider {
    static var previews: some View {
        BLEScan()
    }
}
