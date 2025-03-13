import SwiftUI

struct PesoTeste: View {
    @State var dados: Bool = true
    let actualDate = Date.now
    @State var meta: Int = 95
    @State var pesoAtual: Float = 90
    
    // Define the same blue color used in the CardioTrackerView
    let azul = Color.blue
    let minhaCor = Color.red
    
    var body: some View {
        ScrollView {
            ZStack {
                // Background - same as CardioTrackerView
                LinearGradient(
                    gradient: Gradient(colors: [Color.white.opacity(0.9), Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Header - matching the CardioTrackerView style
                    HStack {
                        Text("PESO")
                            .foregroundColor(.white)
                            .frame(width: 130)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(azul.opacity(0.8))
                                    .shadow(color: azul.opacity(0.5), radius: 10, x: 0, y: 5)
                            )
                            .padding(.top, 50)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    // Current weight display - similar to timer circle in CardioTrackerView
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [azul, azul.opacity(0.8)]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 200, height: 200)
                            .shadow(color: azul.opacity(0.6), radius: 15, x: 0, y: 8)
                        
                        VStack {
                            Text("\(String(format: "%.1f", pesoAtual))")
                                .font(.system(size: 40, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                            
                            Text("KG")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(.white.opacity(0.9))
                            
                            Text("Meta: \(meta) KG")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(.white.opacity(0.9))
                                .padding(.top, 5)
                        }
                    }
                    .padding(.top, 20)
                    
                    // Weight history list
                    VStack(spacing: 15) {
                        Text("HISTÓRICO DE PESO")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(azul)
                            .padding(.top, 5)
                        
                        ForEach((1...31).reversed(), id: \.self) { i in
                            HStack {
                                Text("\(i)/03/2025")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.black.opacity(0.7))
                                
                                Spacer()
                                
                                Text("\(String(format: "%.1f", pesoAtual)) KG")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(dados ? .green : minhaCor)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white.opacity(0.9))
                                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(dados ? Color.green.opacity(0.3) : minhaCor.opacity(0.3), lineWidth: 1)
                            )
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white.opacity(0.9))
                            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
                    )
                    .padding(.horizontal)
                    
                    // Register new weight button - similar to finish button in CardioTrackerView
                    Button(action: {
                        // Action to add new weight entry
                    }) {
                        Text("REGISTRAR NOVO PESO")
                            .foregroundColor(.white)
                            .frame(width: 220)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .padding()
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [azul, azul.opacity(0.8)]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                                .cornerRadius(15)
                                .shadow(color: azul.opacity(0.5), radius: 10, x: 0, y: 5)
                            )
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                }
                .padding(.bottom, 20)
            }
        }
    }
}

struct PesoTeste_Previews: PreviewProvider {
    static var previews: some View {
        PesoTeste()
    }
}
