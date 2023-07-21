//
//  ContentView.swift
//  SwiftTest
//
//  Created by Oscar Hernandez on 19/07/23.
//

import SwiftUI
import AVKit
import CoreMotion

struct MainView: View {
    let motionManager = CMMotionManager()
    
    @StateObject private var coordinator = Coordinator()
    
    @State private var isRunning = false
    @State private var isPlaying = false
    @State private var isReady = false
    @State private var isPresentMenu = false
    @State private var countdown = K.INITIAL_COUNTDOWN
    @State var timer : Timer?
    @State var timerAccelerometer : Timer?
    @State private var vibrateTimes = K.VIBRATION_TIMES
    
    @State var audioPlayer: AVAudioPlayer!
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: onOpenMenu) {
                            Image(systemName: "line.3.horizontal").resizable().frame(width: 50, height: 50)
                        }
                    }
                    Spacer()
                    Text(convertToString(time: countdown)).font(.system(size: 65))
                    Spacer()
                    if isRunning {
                        Button(action: onPause) {
                            Text(isPlaying ? "Pausar" : "Reanudar").font(.system(size: 65)).padding().frame(width: 350)
                        }
                        .background(Color.orange)
                        .cornerRadius(100)
                    } else {
                        Text("Configurada \nEsperando para iniciar...").font(.title).multilineTextAlignment(.center).hidden(!isReady)
                    }
                    Spacer()
                    Button(action: onOk) {
                        Text(isReady ? "Cancelar" : "Aceptar").font(.system(size: 65)).padding().frame(width: 350)
                    }
                    .background(isReady ? Color.red : Color.orange)
                    .cornerRadius(100)
                    Spacer()
                } // VStack
                .foregroundColor(Color.white)
                .background(Rectangle().fill(Color.black).ignoresSafeArea())
                .navigationDestination(for: Page.self) { page in
                    coordinator.build(page: page)
                }
                if isPresentMenu {
                    ModalMask(onTap: {
                        dismissModal()
                    })
                }
                HStack {
                    Spacer()
                    VStack {
                        Button(action: onOpenMenu) {
                            Image(systemName: "line.3.horizontal").resizable().frame(maxWidth: 200, maxHeight: 50).foregroundColor(Color.white)
                        }
                        Spacer()
                        Button(action: toSetup) {
                            HStack {
                                Image(systemName: "gearshape.fill").resizable().frame(width: 40, height: 40).foregroundColor(Color.gray)
                                Text("Configuración")
                            }
                        }
                        Spacer()
                        Button(action: toComments) {
                            HStack {
                                Image(systemName: "doc.text").resizable().frame(width: 40, height: 50).foregroundColor(Color.gray)
                                Text("Comentarios")
                            }
                        }
                        Spacer()
                    }
                    .foregroundColor(Color.black)
                    .frame(width: 200)
                    .font(.title3)
                    .fontWeight(.bold)
                    .background(Rectangle().fill(Color.orange))
                }
                .offset(CGSize(width: isPresentMenu ? 0 : 200, height: 0))
            } // ZStack
        }// NavigationStack
        .environmentObject(coordinator)
        .onAppear {
                motionManager.startAccelerometerUpdates()
                motionManager.accelerometerUpdateInterval = 0.2
        }
    }
}

extension MainView {
    func onOpenMenu() {
        withAnimation {
            isPresentMenu.toggle()
        }
    }
    
    func dismissModal() {
        withAnimation {
            isPresentMenu = false
        }
    }
    
    func onPause() {
        if isPlaying {
            timer?.invalidate()
        } else {
            onStartTimer()
        }
        isPlaying.toggle()
    }
    
    func onOk() {
        if (isRunning) {
            isRunning = false
            isPlaying = false
            
            timer?.invalidate()
            countdown = K.INITIAL_COUNTDOWN
        }
        if !isReady {
            timerAccelerometer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { t1 in
                if let data = motionManager.accelerometerData {
                    if isOnFlatSurface(x: data.acceleration.x, y: data.acceleration.y) {
                        t1.invalidate()
                        isRunning = true
                        isPlaying = true
                        onStartTimer()
                    }
                }
            }
        } else {
            isRunning = false
            isPlaying = false
            isReady = false
            timerAccelerometer?.invalidate()
        }
        
        isReady.toggle()
    }
    
    func onStartTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { t in
            if (countdown > 0) {
                countdown -= 1
            } else {
                t.invalidate()
                if coordinator.selectedAlarmType != .vibration {
                    playAlarm(alarm: coordinator.selectedSound)
                }
                if coordinator.selectedAlarmType != .sound {
                    vibration(type: coordinator.selectedVibration)
                }
            }
        })
    }
    
    func toSetup() {
        withAnimation {
            isPresentMenu = false
        }
        coordinator.push(.setup)
    }
    
    func toComments() {
        withAnimation {
            isPresentMenu = false
        }
        coordinator.push(.comments)
    }
    
    func convertToString(time: Int) -> String {
        let hours = time / 3600
        let minutes = (time - hours * 3600) / 60
        let seconds = time - hours * 3600 - minutes * 60
        let hoursS = hours >= 10 ? String(hours) : "0\(hours)"
        let minutesS = minutes >= 10 ? String(minutes) : "0\(minutes)"
        let secondsS = seconds >= 10 ? String(seconds) : "0\(seconds)"
        return "\(hoursS):\(minutesS):\(secondsS)"
    }
    
    func playAlarm(alarm: SoundType) {
        var name: String?
        switch alarm {
        case .sound1:
            name = "Sound1"
        case .sound2:
            name = "Sound2"
        }
        let sound = Bundle.main.path(forResource: name!, ofType: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOf: URL.init(filePath: sound!))
        audioPlayer.play()
    }
    
    
    func isOnFlatSurface(x: Double, y: Double) -> Bool {
        let mod = sqrt(pow(x, 2) + pow(y, 2))
        return mod < 0.1
    }
    
    func vibration(type: VibrationType) {
        var notificationType:UINotificationFeedbackGenerator.FeedbackType?
        switch type {
        case .vibration1:
            notificationType = .error
        case.vibration2:
            notificationType = .success
        }
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { t1 in
            if vibrateTimes > 0 {
                vibrateTimes -= 1
                HapticManager.instance.notification(type: notificationType!)
            } else {
                vibrateTimes = K.VIBRATION_TIMES
                t1.invalidate()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
