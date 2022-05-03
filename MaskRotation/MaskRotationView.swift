//
//  MaskRotationView.swift
//  Animations
//
//  Created by Loic D on 17/04/2022.
//

import SwiftUI

struct MaskRotationView: View {
    
    @State var zoomedIn = false
    var imageSize: CGFloat {
        return zoomedIn ? 500 : 350
    }
    var xOffset: CGFloat {
        return zoomedIn ? 80 : 20
    }
    var yOffset: CGFloat {
        return zoomedIn ? -10 : -20
    }
    
    var body: some View {
        VStack {
            ZStack {
                ImageView(zoomedIn: $zoomedIn)
                    .mask(MaskView(zoomedIn: $zoomedIn))
                Image("JugCutof")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .offset(x: xOffset, y: yOffset)
                    .frame(height: imageSize)
                    .animation(.easeInOut(duration: 0.5))
                ZoomedInPanelView(zoomedIn: $zoomedIn)
                ZoomedOutPanelView(zoomedIn: $zoomedIn)
            }
            
            Spacer()
        }.ignoresSafeArea()
            .background(Color.white)
            .onTapGesture {
                zoomedIn.toggle()
            }
    }
}

struct MaskView: View {
    
    @Binding var zoomedIn: Bool
    @State var xOffset: CGFloat = 65
    @State var yOffset: CGFloat = -120
    @State var rotation: CGFloat = 0
    @State var maskSize: CGFloat = 550
    
    var body: some View {
        Rectangle()
            .frame(width: maskSize, height: maskSize)
            .cornerRadius(80)
            .rotationEffect(Angle.degrees(rotation))
            .offset(x: xOffset, y: yOffset)
            .onChange(of: zoomedIn) { _ in
                withAnimation(.easeInOut(duration: 0.5)) {
                    if zoomedIn {
                        rotation = 40
                        xOffset = 20
                        yOffset = -360
                        maskSize = 850
                    } else {
                        rotation = 0
                        xOffset = 65
                        yOffset = -120
                        maskSize = 550
                    }
                }
            }
    }
}

struct ZoomedInPanelView: View {
    
    @Binding var zoomedIn: Bool
    @State var opacity: CGFloat = 0
    @State var yOffsets: [CGFloat] = Array(repeating: 0, count: 2)
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Story of Juggernaut")
                .font(.title2)
                .foregroundColor(.orange)
                .opacity(opacity)
                .padding([.top, .bottom], 8)
                .offset(y: yOffsets[0])
            Text("No one has ever seen the face hidden beneath the mask of Yurnero the Juggernaut. It is only speculation that he even has one. For defying a corrupt lord, Yurnero was exiled from the ancient Isle of Masks--a punishment that saved his life. The isle soon after vanished beneath the waves in a night of vengeful magic. He alone remains to carry on the Isle's long Juggernaut tradition, one of ritual and swordplay. The last practitioner of the art, Yurnero's confidence and courage are the result of endless practice; his inventive bladework proves that he has never stopped challenging himself. Still, his motives are as unreadable as his expression. For a hero who has lost everything twice over, he fights as if victory is a foregone conclusion.")
                .font(.subheadline)
                .offset(y: yOffsets[1])
            Spacer()
        }.padding([.leading, .trailing], 24)
        .frame(width: UIScreen.main.bounds.width, height: 500 , alignment: .leading)
        .onChange(of: zoomedIn) { _ in
            if zoomedIn {
                for i in 0..<yOffsets.count {
                    withAnimation(.easeInOut(duration: 0.5).delay(0.2 + Double(i) * 0.15)) {
                        yOffsets[i] = UIScreen.main.bounds.height / 2
                    }
                }
                withAnimation(.easeInOut(duration: 1).delay(0.2)) {
                    opacity = 1
                }
            } else {
                withAnimation(.easeInOut(duration: 0.3)) {
                    opacity = 0
                    for i in 0..<yOffsets.count {
                        yOffsets[i] = UIScreen.main.bounds.height
                    }
                }
            }
        }
        .onAppear {
            for i in 0..<yOffsets.count {
                yOffsets[i] = UIScreen.main.bounds.height
            }
        }
    }
}

struct ZoomedOutPanelView: View {
    
    @Binding var zoomedIn: Bool
    @State var opacity: CGFloat = 1
    @State var yOffsets: [CGFloat] = Array(repeating: 0, count: 5)
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Juggernaut")
                .font(.largeTitle)
                .fontWeight(.bold)
                .opacity(opacity)
                .padding(.bottom, 8)
                .offset(y: yOffsets[0])
            Text("Hero Skills")
                .font(.title2)
                .foregroundColor(.orange)
                .opacity(opacity)
                .offset(y: yOffsets[1])
            HStack {
                VStack {
                    Image("Skill1")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .cornerRadius(40)
                        .shadow(color: Color.init(UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)), radius: 4, x: 0, y: 0)
                    Text("Blade Fury")
                        .font(.subheadline)
                }
                Spacer()
                VStack {
                    Image("Skill2")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .cornerRadius(40)
                        .shadow(color: Color.init(UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)), radius: 4, x: 0, y: 0)
                    Text("Healing Ward")
                        .font(.subheadline)
                }
                Spacer()
                VStack {
                    Image("Skill3")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .cornerRadius(40)
                        .shadow(color: Color.init(UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)), radius: 4, x: 0, y: 0)
                    Text("Blade Dance")
                        .font(.subheadline)
                }
                Spacer()
                VStack {
                    Image("Skill4")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .cornerRadius(40)
                        .shadow(color: Color.init(UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)), radius: 4, x: 0, y: 0)
                    Text("Omni Slash")
                        .font(.subheadline)
                }
            }.offset(y: yOffsets[2])
            .opacity(opacity)
            Text("Summary")
                .font(.title2)
                .foregroundColor(.orange)
                .opacity(opacity)
                .padding([.top, .bottom], 8)
                .offset(y: yOffsets[3])
            Text("Yurnero, the Juggernaut, is a melee agility hero whose abilities allow him to sprint into battle and recklessly devastate enemies in an impenetrable flurry of blades.")
                .font(.subheadline)
                .opacity(opacity)
                .offset(y: yOffsets[4])
            Spacer()
        }.padding([.leading, .trailing], 24)
        .frame(width: UIScreen.main.bounds.width, height: 500 , alignment: .leading)
        .onChange(of: zoomedIn) { _ in
            if !zoomedIn {
                for i in 0..<yOffsets.count {
                    withAnimation(.easeInOut(duration: 0.5).delay(0.2 + Double(i) * 0.15)) {
                        yOffsets[i] = UIScreen.main.bounds.height / 2
                    }
                }
                withAnimation(.easeInOut(duration: 1).delay(0.3)) {
                    opacity = 1
                }
            } else {
                withAnimation(.easeInOut(duration: 0.2)) {
                    opacity = 0
                    for i in 0..<yOffsets.count {
                        yOffsets[i] = UIScreen.main.bounds.height
                    }
                }
            }
        }
        .onAppear {
            for i in 0..<yOffsets.count {
                yOffsets[i] = UIScreen.main.bounds.height / 2
            }
        }
    }
}

struct ImageView: View {
    
    @Binding var zoomedIn: Bool
    
    var imageSize: CGFloat {
        return zoomedIn ? 500 : 350
    }
    var xOffset: CGFloat {
        return zoomedIn ? 80 : 20
    }
    var yOffset: CGFloat {
        return zoomedIn ? -10 : -20
    }
    
    var body: some View {
        ZStack {
            Color.red
            Image("Jug")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .offset(x: xOffset, y: yOffset)
                .frame(height: imageSize)
                .animation(.easeInOut(duration: 0.5))
        }.frame(width: .infinity, height: 550)
    }
}

struct MaskRotationView_Previews: PreviewProvider {
    static var previews: some View {
        MaskRotationView()
    }
}
