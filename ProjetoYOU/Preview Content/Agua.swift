import SwiftUI

struct Agua: View {
    // Controla o nível atual de água (0 a 100)
    @State private var nivelDeAgua: CGFloat = 0
    
    // Cor principal e secundária para manter consistência com a Home
    let minhaCor = Color.blue
    let azul = Color.blue.opacity(0.8)
    
    var body: some View {
        ZStack {
            // Fundo gradiente igual ao da Home
            LinearGradient(
                gradient: Gradient(colors: [Color.white.opacity(0.9), Color.white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                // Cabeçalho "ÁGUA" no mesmo estilo do "MEU DIA"
                HStack{
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
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 25) {
                        // Indicador de água circular com espaçamento adequado
                        ZStack {
                            // Círculo de fundo
                            Circle()
                                .stroke(lineWidth: 20)
                                .foregroundColor(.gray.opacity(0.2))
                                .frame(width: 200, height: 200)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                            
                            // Círculo que representa o nível da água
                            Circle()
                                .trim(from: 0, to: nivelDeAgua / 100)
                                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                                .foregroundColor(minhaCor)
                                .rotationEffect(.degrees(-90))
                                .frame(width: 200, height: 200)
                                .shadow(color: minhaCor.opacity(0.5), radius: 5, x: 0, y: 2)
                                .animation(.easeInOut(duration: 0.5), value: nivelDeAgua)
                            
                            // Texto central
                            VStack(spacing: 2) {
                                Text("\(Int(nivelDeAgua * 20))")
                                    .font(.system(size: 50, weight: .bold, design: .rounded))
                                    .foregroundColor(minhaCor)
                                
                                Text("ml's")
                                    .font(.system(size: 24, weight: .semibold, design: .rounded))
                                    .foregroundColor(minhaCor.opacity(0.8))
                                
                                if(nivelDeAgua >= 100) {
                                    Text("Meta Batida!")
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                        .foregroundColor(minhaCor)
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 12)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color.white)
                                                .shadow(color: minhaCor.opacity(0.3), radius: 5, x: 0, y: 2)
                                        )
                                }
                            }
                        }
                        .padding(.top, 30)
                        .frame(maxHeight: 250)
                        
                        // Estatísticas diárias usando cards no estilo da Home
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Progresso Diário")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(minhaCor)
                                .padding(.leading, 15)
                            
                            HStack(spacing: 15) {
                                // Card 1: Copos bebidos
                                VStack {
                                    Text(Int(nivelDeAgua / 10).description)
                                        .font(.system(size: 30, weight: .bold, design: .rounded))
                                        .foregroundColor(.white)
                                    
                                    Text("copos")
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                        .foregroundColor(.white.opacity(0.9))
                                }
                                .frame(width: 110, height: 100)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [minhaCor, minhaCor.opacity(0.8)]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .shadow(color: minhaCor.opacity(0.4), radius: 8, x: 0, y: 4)
                                )
                                
                                // Card 2: Porcentagem da meta
                                VStack {
                                    Text("\(Int(nivelDeAgua))%")
                                        .font(.system(size: 30, weight: .bold, design: .rounded))
                                        .foregroundColor(.white)
                                    
                                    Text("da meta")
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                        .foregroundColor(.white.opacity(0.9))
                                }
                                .frame(width: 110, height: 100)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [azul, azul.opacity(0.8)]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .shadow(color: azul.opacity(0.4), radius: 8, x: 0, y: 4)
                                )
                            }
                        }
                        .padding(.top, 20)
                        
                        // Botões para adicionar e diminuir água
                        VStack(spacing: 25) { // Aumentei o espaçamento para dar mais área para a sombra
                            // Botão para adicionar água
                            Button(action: {
                                withAnimation {
                                    if nivelDeAgua < 100 {
                                        nivelDeAgua += 10 // Aumenta 10% de cada vez
                                    }
                                }
                            }) {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.title2)
                                    
                                    Text("ADICIONAR ÁGUA")
                                        .font(.system(size: 18, weight: .bold, design: .rounded))
                                }
                                .padding()
                                .frame(width: 230)
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [minhaCor, minhaCor.opacity(0.8)]),
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                            }
                            .shadow(color: minhaCor.opacity(0.6), radius: 8, x: 0, y: 4) // Movido o shadow para aplicar no Button inteiro
                            .padding(.horizontal, 10) // Adicionado padding horizontal para evitar corte lateral
                            
                            // Botão para diminuir água
                            Button(action: {
                                withAnimation {
                                    if nivelDeAgua > 0 {
                                        nivelDeAgua -= 10 // Diminui 10% de cada vez
                                    }
                                }
                            }) {
                                HStack {
                                    Image(systemName: "minus.circle.fill")
                                        .font(.title2)
                                    
                                    Text("DIMINUIR ÁGUA")
                                        .font(.system(size: 18, weight: .bold, design: .rounded))
                                }
                                .padding()
                                .frame(width: 230)
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [azul, azul.opacity(0.8)]),
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                            }
                            .shadow(color: azul.opacity(0.6), radius: 8, x: 0, y: 4) // Movido o shadow para aplicar no Button inteiro
                            .padding(.horizontal, 10) // Adicionado padding horizontal para evitar corte lateral
                        }
                        .padding(.top, 30)
                        .padding(.bottom, 10) // Adicionado padding inferior para acomodar as sombras
                        
                        // Botão "SALVAR" no mesmo estilo do "ENVIAR" da Home
                        Button("SALVAR") {
                            // Ação para salvar o consumo de água
                        }
                        .foregroundColor(.white)
                        .frame(width: 150)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [azul, azul.opacity(0.8)]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .cornerRadius(15)
                        )
                        .shadow(color: azul.opacity(0.5), radius: 8, x: 0, y: 4) // Movido o shadow para aplicar no Button inteiro
                        .padding(.top, 20)
                        .padding(.bottom, 30)
                    }
                    .padding(.horizontal) // Adicionado padding horizontal para evitar corte das sombras
                }
            }
        }
    }
}

#Preview {
    Agua()
}
