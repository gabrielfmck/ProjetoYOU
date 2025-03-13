import SwiftUI

struct SonoPrototipo: View {
    @State var selectedWakeUpTime = Date()
    @State var selectedSleepTime = Date()
    let actualDate = Date.now
    @State private var expandedIndex: Int? = nil
    
    var body: some View {
        ZStack {
            // Fundo gradiente como no Home
            LinearGradient(
                gradient: Gradient(colors: [Color.white.opacity(0.9), Color.white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                // Cabeçalho com título "SONO" no mesmo estilo da Home
                HStack {
                    Text("SONO")
                        .foregroundColor(.white)
                        .frame(width: 130)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(azul)
                                .shadow(color: azul.opacity(0.5), radius: 10, x: 0, y: 5)
                        )
                        .padding(.top, 1)
                    Spacer()
                }
                .padding(.horizontal)
                
                ScrollView {
                    // Card para os registros de sono anteriores
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [minhaCor, minhaCor.opacity(0.8)]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .shadow(color: minhaCor.opacity(0.6), radius: 15, x: 0, y: 8)
                            .frame(width: 240)
                        
                        VStack {
                            // Título com a data
                            Text(actualDate, format: .dateTime.day().month())
                                .padding(.top, 30)
                                .font(.system(size: 40, weight: .heavy))
                                .foregroundColor(.white)
                            
                            // Informações de sono
                            VStack(spacing: 12) {
                                HStack {
                                    Text("Dormi")
                                        .font(.system(size: 18, weight: .medium, design: .rounded))
                                        .foregroundColor(.white)
                                    
                                    Text(selectedSleepTime.formatted(date: .omitted, time: .shortened))
                                        .font(.system(size: 18, weight: .bold, design: .rounded))
                                        .foregroundColor(.white)
                                }
                                
                                HStack {
                                    Text("Acordei")
                                        .font(.system(size: 18, weight: .medium, design: .rounded))
                                        .foregroundColor(.white)
                                    
                                    Text(selectedWakeUpTime.formatted(date: .omitted, time: .shortened))
                                        .font(.system(size: 18, weight: .bold, design: .rounded))
                                        .foregroundColor(.white)
                                }
                            }
                            .padding()
                            .background(Color.white.opacity(0.15))
                            .cornerRadius(12)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                        }
                    }
                    .padding(.top, 40)
                    .padding(.bottom, 20)
                    
                    // Card para registro do sono atual
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [azul, azul.opacity(0.8)]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .shadow(color: azul.opacity(0.6), radius: 15, x: 0, y: 8)
                            .frame(width: 280)
                        
                        VStack {
                            Text("Registrar Sono")
                                .padding(.top, 15)
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                            
                            VStack(spacing: 16) {
                                HStack {
                                    Text("Dormi")
                                        .font(.system(size: 18, weight: .medium, design: .rounded))
                                        .foregroundColor(.white)
                                        .frame(width: 80, alignment: .leading)
                                    
                                    DatePicker("", selection: $selectedSleepTime, displayedComponents: .hourAndMinute)
                                        .datePickerStyle(CompactDatePickerStyle())
                                        .labelsHidden()
                                        .frame(width: 100, height: 30)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color.white.opacity(0.2))
                                        )
                                        .colorInvert()
                                        .colorMultiply(.white)
                                }
                                
                                HStack {
                                    Text("Acordei")
                                        .font(.system(size: 18, weight: .medium, design: .rounded))
                                        .foregroundColor(.white)
                                        .frame(width: 80, alignment: .leading)
                                    
                                    DatePicker("", selection: $selectedWakeUpTime, displayedComponents: .hourAndMinute)
                                        .datePickerStyle(CompactDatePickerStyle())
                                        .labelsHidden()
                                        .frame(width: 100, height: 30)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color.white.opacity(0.2))
                                        )
                                        .colorInvert()
                                        .colorMultiply(.white)
                                }
                            }
                            .padding()
                            .background(Color.white.opacity(0.15))
                            .cornerRadius(12)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                        }
                        .padding(.vertical, 15)
                    }
                    .padding(.bottom, 30)
                    
                    // Botão de salvar
                    Button(action: {
                        // Ação para salvar os dados
                    }) {
                        Text("SALVAR")
                            .padding()
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .frame(width: 150)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [minhaCor, minhaCor.opacity(0.8)]),
                                               startPoint: .leading,
                                               endPoint: .trailing)
                            )
                            .cornerRadius(25)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                            .shadow(color: minhaCor.opacity(0.6), radius: 10, x: 0, y: 5)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 30)
                }
            }
            .padding()
        }
    }
}

// Prévia para o SwiftUI Canvas
#Preview {
    SonoPrototipo()
}
