import SwiftUI

struct Monitorias: View {
    // Cores consistentes com a tela de Água
    let minhaCor = Color.blue
    let azul = Color.blue.opacity(0.8)
    
    var body: some View {
        NavigationView {
            ZStack {
                // Fundo gradiente igual ao da tela de Água
                LinearGradient(
                    gradient: Gradient(colors: [Color.white.opacity(0.9), Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack {
                    // Cabeçalho "MONITORAMENTO" no mesmo estilo do "ÁGUA"
                    HStack {
                        Text("MONITORAMENTO")
                            .foregroundColor(.white)
                            .frame(width: 180)
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
                        VStack(spacing: 20) {
                            // Item de monitoramento: Sono com navegação
                            NavigationLink(destination: SonoPrototipo()) {
                                monitoringItem(
                                    icon: "powersleep",
                                    text: "Sono",
                                    iconColor: .yellow
                                )
                            }
                            
                            // Item de monitoramento: Batimentos cardíacos com navegação
                            NavigationLink(destination: HeartRateMonitorView()) {
                                monitoringItem(
                                    icon: "suit.heart.fill",
                                    text: "Média de batimentos",
                                    iconColor: .red
                                )
                            }
                            
                            // Item de monitoramento: Peso
                            NavigationLink(destination: PesoTeste()) {
                                monitoringItem(
                                    icon: "scalemass.fill",
                                    text: "Peso atual",
                                    iconColor: .green
                                )
                            }
                            // Item de monitoramento: Água com navegação
                            NavigationLink(destination: RegistroAgua()) {
                                monitoringItem(
                                    icon: "drop.fill",
                                    text: "Meta de Água",
                                    iconColor: .white
                                )
                            }
                            
                            // Botão "ATUALIZAR" no mesmo estilo do "SALVAR" da tela de Água
                            Button("ATUALIZAR") {
                                // Ação para atualizar os dados de monitoramento
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
                            .shadow(color: azul.opacity(0.5), radius: 8, x: 0, y: 4)
                            .padding(.top, 30)
                            .padding(.bottom, 20)
                        }
                        .padding(.top, 20)
                        .padding(.horizontal)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    // Função para criar itens de monitoramento com estilo consistente
    private func monitoringItem(icon: String, text: String, iconColor: Color) -> some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(iconColor)
                .padding(.trailing, 5)
                
            Text(text)
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                
            Spacer()
            
            // Seta para indicar que é um item clicável
            Image(systemName: "chevron.right")
                .foregroundColor(.white.opacity(0.7))
                .font(.system(size: 14, weight: .bold))
                .padding(.trailing, 5)
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 20)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [minhaCor, minhaCor.opacity(0.8)]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .cornerRadius(25)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.white, lineWidth: 2)
        )
        .shadow(color: minhaCor.opacity(0.6), radius: 8, x: 0, y: 4)
        .padding(.horizontal, 10)
    }
}

#Preview {
    Monitorias()
}
