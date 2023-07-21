//
//  SetupView.swift
//  SwiftTest
//
//  Created by Oscar Hernandez on 19/07/23.
//

import SwiftUI

struct SetupView: View {
    @EnvironmentObject private var coordinator: Coordinator
    
    @State var cbVibrationAndSound = true
    @State var cbJustVibration = false
    @State var cbJustSound = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: onBackPressed) {
                    Image(systemName: "arrow.backward").resizable().frame(width: 50, height: 50)
                }
                .padding()
                Spacer()
            }
            Spacer()
                .frame(height: 20.0)
            VStack {
                Checkbox(label: "Vibración y Sonido", onChange: {c in selectAlarmType(type: .soundAndVibration)}, isChecked: $cbVibrationAndSound)
                Checkbox(label: "Solo Sonido", onChange: {c in selectAlarmType(type: .sound)}, isChecked: $cbJustVibration)
                Checkbox(label: "Solo Vibración", onChange: {c in selectAlarmType(type: .vibration)}, isChecked: $cbJustSound)
            } // VStack
            .padding()
            Spacer()
            VStack {
                HStack(alignment: .top, spacing: 20.0) {
                    Text("Sonidos:")
                    VStack {
                        Button(action: {
                            selectSound(sound: .sound1)
                        }, label: {
                            Text("Sonido 1")
                                .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                                .background(coordinator.selectedSound == .sound1 ? Color.green : Color.white).cornerRadius(15)
                        })
                        Button(action: {
                            selectSound(sound: .sound2)
                        }, label: {
                            Text("Sonido 2")
                                .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                                .background(coordinator.selectedSound == .sound2 ? Color.green : Color.white).cornerRadius(15)
                        })
                    }
                }
            } // VStack
            .font(.title)
            Spacer()
                .frame(height: 50)
            VStack {
                HStack(alignment: .top, spacing: 20.0) {
                    Text("Vibración:")
                    VStack {
                        Button(action: {
                            selectVibration(vibration: .vibration1)
                        }, label: {
                            Text("Vibración 1")
                                .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                                .background(coordinator.selectedVibration == .vibration1 ? Color.green : Color.white).cornerRadius(15)
                        })
                        Button(action: {
                            selectVibration(vibration: .vibration2)
                        }, label: {
                            Text("Vibración 2")
                                .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                                .background(coordinator.selectedVibration == .vibration2 ? Color.green : Color.white).cornerRadius(15)
                        })
                    }
                }
            } // VStack
            .font(.title)
            Spacer()
        } // VStack
        .foregroundColor(Color.black)
        .background(Rectangle().fill(Color.orange).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .onAppear {
            switch coordinator.selectedAlarmType {
            case .soundAndVibration:
                cbVibrationAndSound = true
                cbJustVibration = false
                cbJustSound = false
            case .sound:
                cbVibrationAndSound = false
                cbJustVibration = true
                cbJustSound = false
            case .vibration:
                cbVibrationAndSound = false
                cbJustVibration = false
                cbJustSound = true
            }
        }
    }
}

extension SetupView {
    func selectSound(sound: SoundType) {
        coordinator.selectedSound = sound
    }
    
    func selectVibration(vibration: VibrationType) {
        coordinator.selectedVibration = vibration
    }
    
    func selectAlarmType(type: AlarmType) {
        coordinator.selectedAlarmType = type
        switch type {
        case .soundAndVibration:
            cbVibrationAndSound = true
            cbJustVibration = false
            cbJustSound = false
        case .sound:
            cbVibrationAndSound = false
            cbJustVibration = true
            cbJustSound = false
        case .vibration:
            cbVibrationAndSound = false
            cbJustVibration = false
            cbJustSound = true
        }
    }
    
    func onBackPressed() {
        coordinator.pop()
    }
}

struct SetupView_Previews: PreviewProvider {
    static var previews: some View {
        SetupView()
    }
}
