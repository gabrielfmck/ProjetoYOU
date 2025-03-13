import SwiftUI

struct RegistroAgua: View {
    var dados: Bool = true
    let actualDate = Date.now
    var meta: Int = 12
    
    var body: some View {
        ZStack {
            // Fundo gradiente como nas outras telas
            LinearGradient(
                gradient: Gradient(colors: [Color.white.opacity(0.9), Color.white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                // Cabeçalho no mesmo estilo das outras telas
                HStack {
                    Text("ÁGUA")
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
                    // Card para visualização de cumprimento da meta
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        dados ? Color.green : minhaCor,
                                        dados ? Color.green.opacity(0.8) : minhaCor.opacity(0.8)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .shadow(color: dados ? Color.green.opacity(0.6) : minhaCor.opacity(0.6), radius: 15, x: 0, y: 8)
                            .frame(width: 240, height: 200)
                        
                        VStack {
                            // Título com a data
                            Text(actualDate, format: .dateTime.day().month())
                                .padding(.top, 20)
                                .font(.system(size: 38, weight: .heavy))
                                .foregroundColor(.white)
                            
                            // Ícone de gota d'água
                            Image(systemName: "drop.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                            
                            // Status de meta
                            Text(dados ? "Meta cumprida!" : "Meta não cumprida")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(10)
                        }
                    }
                    .padding(.top, 40)
                    .padding(.bottom, 30)
                    
                    // Card de estatísticas
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
                        
                            VStack(spacing: 15) {
                                Text("Estatísticas")
                                    .font(.system(size: 22, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                    .padding(.top, 10)
                                
                                VStack(spacing: 12) {
                                    HStack {
                                        Image(systemName: "flame.fill")
                                            .foregroundColor(.white)
                                        
                                        Text("Sequência atual:")
                                            .font(.system(size: 16, weight: .medium, design: .rounded))
                                            .foregroundColor(.white)
                                        
                                        Spacer()
                                        
                                        Text("\(meta) dias")
                                            .font(.system(size: 16, weight: .bold, design: .rounded))
                                            .foregroundColor(.white)
                                    }
                                    HStack {
                                        Image(systemName: "chart.bar.fill")
                                            .foregroundColor(.white)
                                        
                                        Text("Progresso hoje:")
                                            .font(.system(size: 16, weight: .medium, design: .rounded))
                                            .foregroundColor(.white)
                                        
                                        Spacer()
                                        
                                        Text(dados ? "100%" : "70%")
                                            .font(.system(size: 16, weight: .bold, design: .rounded))
                                            .foregroundColor(.white)
                                    }
                                }.padding(.horizontal, 10)
                                
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                .background(Color.white.opacity(0.15))
                                .cornerRadius(12)
                                .padding(.horizontal)
                                
                                Text("Você está \(meta) dias cumprindo a meta")
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.white.opacity(0.15))
                                    .cornerRadius(12)
                                    .padding(.horizontal, 15)
                                    .padding(.bottom, 15)
                            }
                        
                    }
                    .padding(.bottom, 30)
                    
                    // Botão para adicionar consumo de água
                    Button(action: {
                        // Ação para adicionar consumo de água
                    }) {
                    }
                    .padding(.bottom, 30)
                }
            }
            .padding()
        }
    }
}

#Preview {
    RegistroAgua()
}
