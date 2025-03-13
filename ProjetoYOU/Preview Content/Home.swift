import SwiftUI
import Foundation

//func enviarDadosParaServidor(pessoa: pessoa) {
//    // URL correta do servidor Node-RED
//    guard let url = URL(string: "http://127.0.0.1:1880/uploadPessoa78") else {
//        print("URL inválida")
//        return
//    }
//
//    // Codificando os dados como JSON
//    do {
//        let encoder = JSONEncoder()
//        encoder.dateEncodingStrategy = .iso8601  // Caso tenha datas no formato ISO 8601
//        let jsonData = try encoder.encode(pessoa)
//
//        // Criando o request
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = jsonData
//
//        // Enviando a requisição
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Erro na requisição: \(error.localizedDescription)")
//                return
//            }
//
//            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
//                // Aqui você pode processar a resposta, se necessário
//                print("Dados enviados com sucesso: \(String(data: data, encoding: .utf8) ?? "")")
//            } else {
//                print("Falha ao enviar os dados.")
//            }
//        }
//
//        // Iniciando a tarefa
//        task.resume()
//    } catch {
//        print("Erro ao codificar os dados: \(error.localizedDescription)")
//    }
//}

struct Home: View {
    // Controla o índice do dia atual (qual card mostrar)
    @State var scrollIndex: Int = 0
    
    // Controla qual card está expandido. Se for nil, nenhum está expandido
    @State private var expandedIndex: Int? = nil
    @State private var estaEditando: Bool = false
    @State private var auxEditar: Bool = false
    @StateObject var vm = ModelView()
    
    @State var textoalmo: String = ""
    @State var textojant : String = ""
    @State var textolanche : String = ""
    
    @State private var estaEditandoCafe: Bool = false
    @State private var estaEditandoAlmo: Bool = false
    @State private var estaEditandoJanta: Bool = false
    @State private var cliquei: Bool = false
    
    // Estado para controlar a apresentação da tela de Cardio
    @State private var isShowingCardioTracker = false
    
    var body: some View{
        ZStack {
            // Fundo gradiente
            LinearGradient(
                gradient: Gradient(colors: [Color.white.opacity(0.9), Color.white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                // Cabeçalho com o logo e título "MEU DIA"
                HStack {
                    // Logo melhorada do aplicativo "YOU"
                    ZStack {
                        // Efeito de brilho externo
                        Circle()
                            .fill(minhaCor.opacity(0.3))
                            .frame(width: 68, height: 68)
                            .blur(radius: 8)
                        
                        // Círculo exterior
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.white, Color.white.opacity(0.7)]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 60, height: 60)
                            .shadow(color: minhaCor.opacity(0.5), radius: 6, x: 0, y: 3)
                        
                        // Círculo interno com gradiente
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [minhaCor, azul]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 52, height: 52)
                        
                        // Texto "YOU" com efeito de sombra
                        Text("YOU")
                            .font(.system(size: 20, weight: .black, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.2), radius: 1, x: 1, y: 1)
                            .rotationEffect(Angle(degrees: -5))
                        
                        // Pequenos círculos decorativos ao redor
                        ForEach(0..<5) { index in
                            Circle()
                                .fill(Color.white)
                                .frame(width: 6, height: 6)
                                .offset(
                                    x: 28 * cos(Double(index) * 2 * .pi / 5),
                                    y: 28 * sin(Double(index) * 2 * .pi / 5)
                                )
                        }
                    }
                    .padding(.leading, 15)
                    
                    Spacer()
                    
                    Text("MEU DIA")
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
                }
                .padding(.horizontal)
                
                ScrollView{
                    // Botão "INICIAR O CARDIO"
                    Button(action: {
                        // Abre a tela de CardioTracker
                        isShowingCardioTracker = true
                    }) {
                        Text("INICIAR O CARDIO")
                            .padding()
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .frame(width: 250)
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
                    .padding(.top, 55)
                    .sheet(isPresented: $isShowingCardioTracker) {
                        CardioTrackerView()
                    }
                    
                    // Layout horizontal: seta esquerda, card atual, seta direita
                    HStack {
                        // Botão para ir ao dia anterior
                        Button (action: {
                            if scrollIndex > 0 {
                                scrollIndex -= 1
                            }
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(12)
                                .background(
                                    Circle()
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [minhaCor, minhaCor.opacity(0.8)]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .shadow(color: minhaCor.opacity(0.4), radius: 8, x: 0, y: 4)
                                )
                        }
                        .padding(.leading, 5)
                        
                        // Pegamos o item (dia) correspondente ao scrollIndex atual
                        let item = arrayData[scrollIndex]
                        
                        ZStack {
                            // Fundo do Card
                            RoundedRectangle(cornerRadius: 20)
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [minhaCor, minhaCor.opacity(0.8)]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .shadow(color: minhaCor.opacity(0.6), radius: 15, x: 0, y: 8)
                            
                            VStack {
                                // Parte principal do card (data e dia)
                                VStack {
                                    Text(item.data)
                                        .padding(.top, 30)
                                        .font(.system(size: 40, weight: .heavy))
                                        .foregroundColor(.white)
                                    
                                    HStack {
                                        Spacer()
                                        Text(item.dia)
                                            .padding()
                                            .foregroundStyle(Color.white.opacity(0.9))
                                            .font(.system(size: 30, weight: .medium, design: .rounded))
                                            //.padding(.trailing, 10)
                                    }
                                }
                                .onTapGesture {
                                    // Ao tocar, expande/colapsa as infos adicionais
                                    withAnimation(.spring()) {
                                        if expandedIndex == scrollIndex {
                                            expandedIndex = nil
                                        } else {
                                            expandedIndex = scrollIndex
                                        }
                                    }
                                }
                                
                                // Se este card estiver expandido, mostra a parte extra
                                if expandedIndex == scrollIndex {
                                    // Rolagem vertical caso as infos sejam grandes
                                    ScrollView(.vertical, showsIndicators: true) {
                                        VStack(alignment: .leading, spacing: 12){
                                            Text("Café da manha:")
                                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                                .foregroundColor(.white)
                                                .padding(.top, 5)
                                            
                                            HStack{
                                                if estaEditandoCafe {
                                                    TextField("Digite algo", text: $textolanche, axis: .vertical)
                                                        .textFieldStyle(PlainTextFieldStyle())
                                                        .foregroundColor(minhaCor)
                                                        .padding()
                                                        .frame(height: 150)
                                                        .background(
                                                            RoundedRectangle(cornerRadius: 12)
                                                                .fill(Color.white)
                                                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                                                        )
                                                        .onChange(of: textolanche) {
                                                            arrayData[scrollIndex].cafeDaManha = textolanche
                                                        }
                                                } else {
                                                    Text(item.cafeDaManha)
                                                        .padding()
                                                        .background(Color.white.opacity(0.15))
                                                        .cornerRadius(12)
                                                }
                                                
                                                Image(systemName: cliquei ? "checkmark.circle.fill" : "pencil")
                                                    .foregroundColor(.white)
                                                    .padding(10)
                                                    .background(
                                                        Circle()
                                                            .fill(azul)
                                                            .shadow(color: azul.opacity(0.5), radius: 5, x: 0, y: 3)
                                                    )
                                                    .onTapGesture {
                                                        cliquei.toggle()
                                                        estaEditandoCafe.toggle()
                                                        textolanche = arrayData[scrollIndex].cafeDaManha
                                                       
                                                    }
                                                
                                            }
                                            .animation(.easeInOut, value: estaEditandoCafe)
                                            
                                            Text("Almoço:")
                                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                                .foregroundColor(.white)
                                                .padding(.top, 5)
                                            
                                            HStack{
                                                if estaEditandoAlmo {
                                                    TextField("Digite algo", text: $textoalmo, axis: .vertical)
                                                        .textFieldStyle(PlainTextFieldStyle())
                                                        .foregroundColor(minhaCor)
                                                        .padding()
                                                        .frame(height: 150)
                                                        .background(
                                                            RoundedRectangle(cornerRadius: 12)
                                                                .fill(Color.white)
                                                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                                                        )
                                                        .onChange(of: textoalmo) {
                                                            arrayData[scrollIndex].almoco = textoalmo
                                                        }
                                                } else {
                                                    Text(item.almoco)
                                                        .padding()
                                                        .background(Color.white.opacity(0.15))
                                                        .cornerRadius(12)
                                                }
                                                
                                                Image(systemName: cliquei ? "checkmark.circle.fill" : "pencil")
                                                    .foregroundColor(.white)
                                                    .padding(10)
                                                    .background(
                                                        Circle()
                                                            .fill(azul)
                                                            .shadow(color: azul.opacity(0.5), radius: 5, x: 0, y: 3)
                                                    )
                                                    .onTapGesture {
                                                        cliquei.toggle()
                                                        estaEditandoAlmo.toggle()
                                                        textoalmo = arrayData[scrollIndex].almoco
                                                       
                                                    }
                                            }
                                            .animation(.easeInOut, value: estaEditandoAlmo)
                                            
                                            Text("Janta:")
                                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                                .foregroundColor(.white)
                                                .padding(.top, 5)
                                            
                                            HStack{
                                                if estaEditandoJanta {
                                                    TextField("Digite algo", text: $textojant, axis: .vertical)
                                                        .textFieldStyle(PlainTextFieldStyle())
                                                        .foregroundColor(minhaCor)
                                                        .padding()
                                                        .frame(height: 150)
                                                        .background(
                                                            RoundedRectangle(cornerRadius: 12)
                                                                .fill(Color.white)
                                                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                                                        )
                                                        .onChange(of: textojant) {
                                                            arrayData[scrollIndex].jantar = textojant
                                                        }
                                                } else {
                                                    Text(item.jantar)
                                                        .padding()
                                                        .background(Color.white.opacity(0.15))
                                                        .cornerRadius(12)
                                                }
                                                
                                                Image(systemName: cliquei ? "checkmark.circle.fill" : "pencil")
                                                    .foregroundColor(.white)
                                                    .padding(10)
                                                    .background(
                                                        Circle()
                                                            .fill(azul)
                                                            .shadow(color: azul.opacity(0.5), radius: 5, x: 0, y: 3)
                                                    )
                                                    .onTapGesture {
                                                        cliquei.toggle()
                                                        estaEditandoJanta.toggle()
                                                        textojant = arrayData[scrollIndex].jantar
                                                       
                                                    }
                                            }
                                            .animation(.easeInOut, value: estaEditandoJanta)
                                        }
                                        .padding()
                                        .foregroundColor(.white)
                                    }
                                    .frame(minHeight: 100) // Limita a altura do "popup"
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(azul.opacity(0.9))
                                            .shadow(color: azul.opacity(0.3), radius: 8, x: 0, y: 4)
                                    )
                                    .padding(.horizontal, 10)
                                    .padding(.bottom, 10)
                                    .transition(.move(edge: .bottom).combined(with: .opacity))
                                }
                            }
                        }
                        .frame(width: 240)
                        .padding(.bottom, expandedIndex == scrollIndex ? 20 : 0)
                        
                        // Botão para ir ao próximo dia
                        Button (action: {
                            if scrollIndex < arrayData.count - 1 {
                                scrollIndex += 1
                            }
                        }) {
                            Image(systemName: "chevron.right")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(12)
                                .background(
                                    Circle()
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [minhaCor, minhaCor.opacity(0.8)]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .shadow(color: minhaCor.opacity(0.4), radius: 8, x: 0, y: 4)
                                )
                        }
                        .padding(5)
                    }
                    .padding(.top, 50)
                    
                    Button("ENVIAR") {
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                    }
                    .foregroundColor(.white)
                    .frame(width: 150)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .padding()
                    .background(
                        LinearGradient(gradient: Gradient(colors: [azul, azul.opacity(0.8)]),
                                       startPoint: .leading,
                                       endPoint: .trailing)
                        .cornerRadius(15)
                        .shadow(color: azul.opacity(0.5), radius: 10, x: 0, y: 5)
                    )
                    .padding(.bottom, 20)
                    .padding(.top, 40)
                }
            }
        }
    }
}

struct EditButton: View {
    @Binding var isEditing: Bool
    @Binding var Aux: Bool
    var body: some View {
        Button(action: {
            isEditing.toggle()
            Aux.toggle()
        }) {
            Image(systemName: isEditing ? "checkmark.circle.fill" : "pencil")
                .foregroundColor(.white)
                .padding(10)
                .background(
                    Circle()
                        .fill(azul)
                        .shadow(color: azul.opacity(0.5), radius: 5, x: 0, y: 3)
                )
        }
    }
}

#Preview {
    Home()
}
