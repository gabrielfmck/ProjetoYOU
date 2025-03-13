//
//  ModelView.swift
//  temp
//
//  Created by Turma02-Backup on 11/03/25.
//

import Foundation

class ModelView : ObservableObject {
    @Published var dadosPessoais: [pessoa] = []
        
        
        func fetch(){
            let url = "http://127.0.0.1:1880/getPessoa"
            
            let task = URLSession.shared.dataTask(with: URL(string: url)!){ dados, _, error in
                
                do {
                    self.dadosPessoais = try JSONDecoder().decode([pessoa].self, from: dados!)
                } catch {
                    print (error)
                }
                
            }
            task.resume()
        }
}
