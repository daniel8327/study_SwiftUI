//
//  ContentView.swift
//  MyFirstSwiftUI
//
//  Created by moonkyoochoi on 2021/04/15.
//

import SwiftUI

struct StandardTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .padding()
            .background(Color.white)
            .border(Color.gray, width: 0.2)
            .shadow(color: .black, radius: 5, x: 0, y: 5)
    }
}

struct MyVStack: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("Text Item 1")
            Text("Text Item 2")
            Text("Text Item 3")
        }
        .font(.largeTitle)
    }
}

struct MyVStack2<Content: View>: View {
    let content: ()-> Content
    
    init(@ViewBuilder aa: @escaping () -> Content) {
        self.content = aa
    }
    
    var body: some View {
        VStack(spacing: 10) {
            content()
        }
        .font(.largeTitle)
    }
}

struct ContentView: View {
    var body: some View {
        ZStack {
            MyVStack2 {
                Text("Text 1")
                Text("Text 2")
                HStack {
                    Image(systemName: "star.fill")
                    Image(systemName: "star.fill")
                    Image(systemName: "star")
                }
            }
            VStack {
                // 일반적인 형태
                Text("Hi, There!")
                    .foregroundColor(Color.red)
                    .padding()
                    .border(Color.black)
                    .font(.custom("Copperplate", size: 70))
                    .font(.largeTitle)
                    .blur(radius: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                
                // ViewModifier 채택
                Text("Hi, 2!")
                    .modifier(StandardTitle())
                
                
                // 일반적으로 함수로 빼는법
                Button(action: buttonPressed) {
                    Text("Click Me")
                }
                
                // 클로저
                Button("title?") {
                    print("a")
                }
                
                // 클로저
                Button(action: {
                    print("bbb")
                }, label: {
                    Text("hiroo")
                })
                
                // 버튼을 이미지로
                Button(action: {
                    print("hello")
                }) {
                    Image(systemName: "square.and.arrow.down")
                }
                
                Button("dismiss", action: {
                    self.onDisappear()
                })
                .onAppear(perform: {
                    print("dismiss 채택한 놈이 나타남")
                })
                .onDisappear(perform: {
                    print("dismiss 채택한 놈이 사라짐")
                })
            }
        }
    }
    
    func buttonPressed() {
        print("pressed")
    }
}

struct SampleStack: View {
    
    @State private var rotation: Double = 0.0
    @State private var textInput: String = "Hiroo"
    @State private var colorIndex = 0
    
    var colors: [Color] = [.black, .red, .green, .blue]
    
    var colorNames = [ Color.black.description.uppercased(),
                       Color.red.description.uppercased(),
                       Color.green.description.uppercased(),
                       Color.blue.description.uppercased()]
//
//    lazy var colorNames2 = {
//        let aa = self.colors.map {
//            $0.description.uppercased()
//        }
//
//        return aa
//    }()
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack {
                
                Text(textInput)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .rotationEffect(.degrees(rotation))
                    .animation(.easeInOut(duration: 5))
                    .foregroundColor(colors[colorIndex])
                
                Slider(value: $rotation, in: 0...360, step: 0.1)
                
                TextField("Enter text here", text: $textInput)
                    .padding(16)
                    .frame(width: geometry.size.width, height: 50, alignment: .center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Picker(selection: .constant(1), label: Text("Picker"), content: {
                    /*@START_MENU_TOKEN@*/Text("1").tag(1)/*@END_MENU_TOKEN@*/
                    /*@START_MENU_TOKEN@*/Text("2").tag(2)/*@END_MENU_TOKEN@*/
                })
                
                Picker(selection: $colorIndex, label: Text("Color Picker"), content: {
                    
//                    self.colorNames.map {
//                        Text($0)
//                    }
                    
                    ForEach (0 ..< self.colorNames.count) {
                        Text(self.colorNames[$0])
                            .foregroundColor(colors[$0])
                    }
                    
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        SampleStack()
        
        ContentView()
        
        MyVStack()
        
        Group {
            
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
                .previewDisplayName("iPhone SE")
                .environment(\.colorScheme, .dark)
            
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
                .previewDisplayName("iPhone 11")
                .environment(\.colorScheme, .dark)
        }
    }
}

