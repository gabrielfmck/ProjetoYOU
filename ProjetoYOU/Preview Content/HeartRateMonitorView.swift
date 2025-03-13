import SwiftUI

struct HeartRateMonitorView: View {
    @State private var averageHeartRate: Int = UserDefaults.standard.integer(forKey: "lastCardioAverageHeartRate")
    @State private var lastCardioDate: Date? = UserDefaults.standard.object(forKey: "lastCardioDate") as? Date
    
    // Sample historical data for demonstration
    @State private var historicalData: [(date: String, value: Int)] = [
        ("Segunda", 75),
        ("Terça", 78),
        ("Quarta", 72),
        ("Quinta", 82),
        ("Sexta", 76),
        ("Sábado", 0),
        ("Domingo", 0)
    ]
    
    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                gradient: Gradient(colors: [Color.white.opacity(0.9), Color.white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                // Header
                HStack {
                    Text("BATIMENTOS")
                        .foregroundColor(.white)
                        .frame(width: 160)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.blue.opacity(0.8))
                                .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 5)
                        )
                        .padding(.top, 1)
                    Spacer()
                }
                .padding(.horizontal)
                
                ScrollView {
                    VStack(spacing: 25) {
                        // Current heart rate display
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.red, Color.red.opacity(0.7)]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 180, height: 180)
                                .shadow(color: Color.red.opacity(0.6), radius: 15, x: 0, y: 8)
                            
                            VStack(spacing: 5) {
                                Text("\(averageHeartRate)")
                                    .font(.system(size: 48, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                
                                Text("BPM")
                                    .font(.system(size: 18, weight: .medium, design: .rounded))
                                    .foregroundColor(.white.opacity(0.9))
                                
                                if let date = lastCardioDate {
                                    Text("\(formattedDate(date))")
                                        .font(.system(size: 18))
                                        .foregroundColor(.white.opacity(0.8))
                                        .padding(.top, 5)
                                }
                            }
                        }
                        .padding(.top, 20)
                        
                        // Heart rate status
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Status")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(Color.blue)
                            
                            HStack {
                                Image(systemName: heartRateStatus(bpm: averageHeartRate).icon)
                                    .font(.title2)
                                    .foregroundColor(heartRateStatus(bpm: averageHeartRate).color)
                                
                                Text(heartRateStatus(bpm: averageHeartRate).message)
                                    .font(.system(size: 16))
                                    .foregroundColor(.black.opacity(0.8))
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        }
                        .padding(.horizontal)
                        .padding(.top, 5)
                        
                        // Weekly history
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Histórico Semanal")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(Color.blue)
                                .padding(.horizontal)
                            
                            // Graph
                            HStack(alignment: .bottom, spacing: 12) {
                                ForEach(historicalData.indices, id: \.self) { index in
                                    VStack {
                                        // If we have data from the latest cardio session, update today's value
                                        let value = index == getDayOfWeekIndex() && averageHeartRate > 0 ?
                                                  averageHeartRate : historicalData[index].value
                                        
                                        Text("\(value > 0 ? "\(value)" : "")")
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(.white)
                                        
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.7)]),
                                                    startPoint: .top,
                                                    endPoint: .bottom
                                                )
                                            )
                                            .frame(width: 30, height: value > 0 ? CGFloat(value) : 5)
                                        
                                        Text(historicalData[index].date)
                                            .font(.system(size: 12))
                                            .foregroundColor(.black.opacity(0.7))
                                    }
                                }
                            }
                            .frame(height: 150, alignment: .bottom)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                            .padding(.horizontal)
                        }
                        
                        // Heart rate information
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Informações")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(Color.blue)
                            
                            infoCard(
                                title: "Frequência Cardíaca em Repouso",
                                content: "Entre 60-100 BPM é considerado normal para adultos.",
                                icon: "heart.text.square.fill"
                            )
                            
                            infoCard(
                                title: "Durante Exercícios",
                                content: "Pode variar de 120-170 BPM dependendo da intensidade.",
                                icon: "figure.run"
                            )
                            
                            infoCard(
                                title: "Zona Alvo para Cardio",
                                content: "50-85% da sua frequência cardíaca máxima (220 - sua idade).",
                                icon: "target"
                            )
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                        .padding(.bottom, 30)
                    }
                }
            }
        }
        .onAppear {
            // Check if we have a new average heart rate value and update the graph
            if averageHeartRate > 0 {
                let dayIndex = getDayOfWeekIndex()
                if dayIndex >= 0 && dayIndex < historicalData.count {
                    var updatedData = historicalData
                    updatedData[dayIndex].value = averageHeartRate
                    historicalData = updatedData
                }
            }
        }
    }
    
    // Helper function to create info cards
    private func infoCard(title: String, content: String, icon: String) -> some View {
        HStack(alignment: .top, spacing: 15) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(Color.blue)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black.opacity(0.8))
                
                Text(content)
                    .font(.system(size: 14))
                    .foregroundColor(.black.opacity(0.6))
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
    
    // Helper function to determine heart rate status
    private func heartRateStatus(bpm: Int) -> (message: String, icon: String, color: Color) {
        if bpm == 0 {
            return ("Nenhum dado registrado", "exclamationmark.circle", .orange)
        } else if bpm < 60 {
            return ("Abaixo do normal", "arrow.down.circle", .blue)
        } else if bpm <= 100 {
            return ("Normal", "checkmark.circle", .green)
        } else if bpm <= 150 {
            return ("Elevado (cardio)", "flame", .orange)
        } else {
            return ("Acima do normal", "exclamationmark.triangle", .red)
        }
    }
    
    // Format date for display
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    // Get the current day of week index (0 = Monday, 6 = Sunday)
    private func getDayOfWeekIndex() -> Int {
        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: Date())
        // Convert from Sunday = 1 to Monday = 0
        return (dayOfWeek + 5) % 7
    }
}

struct HeartRateMonitorView_Previews: PreviewProvider {
    static var previews: some View {
        HeartRateMonitorView()
    }
}
