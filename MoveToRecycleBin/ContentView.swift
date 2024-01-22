//
//  ContentView.swift
//  MoveToRecycleBin
//
//  Created by Angelos Staboulis on 21/1/24.
//

import SwiftUI
struct ContentView: View {
    @State var directoriesArray: [String] = []
    @State var directoryPath:String
    @State var selectedPath:String
    @State var presented:Bool = false
    var body: some View {
        NavigationStack{
            HStack{
                Text("Enter directory path")
                TextField("",text:$directoryPath)
                .padding(30)
                Button {
                    directoriesArray.append(contentsOf: getListPath())
                } label: {
                    Text("Fill List with Files").frame(width:200,height:45)
                }.padding(10)

            }
            List(directoriesArray,id:\.self){ item in
                Text(String(describing:item))
                    .contextMenu {
                        Button {
                            selectedPath = directoryPath + item
                            presented.toggle()
                        } label: {
                            Text("Delete File")
                        }
                    }

            }.alert("Information Message", isPresented: $presented) {
                Button {
                    removeItem(value: selectedPath)
                    presented = false
                } label: {
                    Text("OK")
                }

            } message: {
                Text("Fill will be deleted")
            }
            
        }
    }

    func getListPath()->[String]{
        var temp:[String] = []
        do{
            temp.append(contentsOf:try FileManager.default.contentsOfDirectory(atPath:directoryPath))
        }catch{
            debugPrint("something went wrong!!!!")
        }
        return temp
    }
    func removeItem(value:String){
        for item in 0..<directoriesArray.count{
            let newDirectory = directoryPath + directoriesArray[item]
            if newDirectory.elementsEqual(value){
                do{
                    try FileManager.default.trashItem(at: URL(filePath:value), resultingItemURL: nil)
                    
                }catch{
                    debugPrint("something went wrong!!!!")
                }
                directoriesArray.remove(at: item)
                break
            }
            
        }
        
    }
}

#Preview {
    ContentView(directoryPath: "", selectedPath: "", presented:false)
}
