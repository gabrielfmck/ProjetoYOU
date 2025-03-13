import SwiftUI

struct CardioTrackerView: View {
    @State private var isRunning = false
    @State private var elapsedTime: TimeInterval = 0
    @State private var timer: Timer?
    @State private var heartRateInput = ""
    @State private var heartRateValues: [Int] = []
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView{
            ZStack {
                // Background
                LinearGradient(
                    gradient: Gradient(colors: [Color.white.opacity(0.9), Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Header
                    HStack {
                        Text("CARDIO")
                            .foregroundColor(.white)
                            .frame(width: 130)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .padding()
                        
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.blue.opacity(0.8))
                                    .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 5)
                            )
                            .padding(.top, 50)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    // Timer display
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 200, height: 200)
                            .shadow(color: Color.blue.opacity(0.6), radius: 15, x: 0, y: 8)
                        
                        VStack {
                            Text(timeString(time: elapsedTime))
                                .font(.system(size: 40, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                            
                            if heartRateValues.count > 0 {
                                Text("\(heartRateValues.count) registros")
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundColor(.white.opacity(0.9))
                            }
                        }
                    }
                    .padding(.top, 30)
                    
                    // Control buttons
                    HStack(spacing: 20) {
                        Button(action: {
                            if isRunning {
                                stopTimer()
                            } else {
                                startTimer()
                            }
                        }) {
                            Text(isRunning ? "PAUSAR" : "INICIAR")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 20)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(isRunning ? Color.orange : Color.green)
                                        .shadow(color: isRunning ? Color.orange.opacity(0.5) : Color.green.opacity(0.5), radius: 5, x: 0, y: 3)
                                )
                        }
                        
                        Button(action: {
                            resetTimer()
                        }) {
                            Text("REINICIAR")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 20)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.red)
                                        .shadow(color: Color.red.opacity(0.5), radius: 5, x: 0, y: 3)
                                )
                        }
                    }
                    .padding(.top, 20)
                    
                    // Heart rate input section
                    VStack(spacing: 15) {
                        Text("REGISTRAR BATIMENTOS")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(Color.blue)
                        
                        HStack {
                            TextField("BPM", text: $heartRateInput)
                                .keyboardType(.numberPad)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                                .frame(width: 150)
                            
                            Button(action: {
                                addHeartRate()
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 28))
                                    .foregroundColor(Color.blue)
                            }
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white.opacity(0.9))
                            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
                    )
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // Heart rate values list
                    if !heartRateValues.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(heartRateValues.indices, id: \.self) { index in
                                    Text("\(heartRateValues[index]) BPM")
                                        .font(.system(size: 14, weight: .medium))
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 15)
                                        .background(
                                            Capsule()
                                                .fill(Color.blue.opacity(0.2))
                                        )
                                        .overlay(
                                            Capsule()
                                                .stroke(Color.blue.opacity(0.5), lineWidth: 1)
                                        )
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(height: 50)
                    }
                    
                    // Finish button
                    Button(action: {
                        if heartRateValues.isEmpty {
                            showAlert = true
                        } else {
                            finishCardio()
                        }
                    }) {
                        Text("FINALIZAR CARDIO")
                            .foregroundColor(.white)
                            .frame(width: 200)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .padding()
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                                .cornerRadius(15)
                                .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 5)
                            )
                    }
                    .padding(.top, 20)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Sem Registros"),
                            message: Text("Você precisa registrar pelo menos um valor de batimento cardíaco."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    
                    Spacer()
                }
            }
            .onDisappear {
                stopTimer()
            }
        }
    }
    
    // Start the timer
    private func startTimer() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.elapsedTime += 0.1
        }
    }
    
    // Stop the timer
    private func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    // Reset the timer
    private func resetTimer() {
        stopTimer()
        elapsedTime = 0
        heartRateValues = []
    }
    
    // Add heart rate value
    private func addHeartRate() {
        guard let heartRate = Int(heartRateInput), heartRate > 0 else { return }
        heartRateValues.append(heartRate)
        heartRateInput = ""
        // Dismiss keyboard
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    // Calculate average heart rate and finish cardio session
    private func finishCardio() {
        stopTimer()
        
        // Calculate average heart rate
        let averageHeartRate = heartRateValues.reduce(0, +) / heartRateValues.count
        
        // Save to user defaults for retrieval in the heart rate monitoring screen
        UserDefaults.standard.set(averageHeartRate, forKey: "lastCardioAverageHeartRate")
        UserDefaults.standard.set(Date(), forKey: "lastCardioDate")
        
        // Return to previous screen
        presentationMode.wrappedValue.dismiss()
    }
    
    // Format time as MM:SS.ms
    private func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let milliseconds = Int((time.truncatingRemainder(dividingBy: 1)) * 10)
        return String(format: "%02d:%02d.%01d", minutes, seconds, milliseconds)
    }
}

struct CardioTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        CardioTrackerView()
    }
}
