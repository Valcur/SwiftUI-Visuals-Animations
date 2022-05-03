//
//  WalkingSwipeView.swift
//  Animations
//
//  Created by Loic D on 15/04/2022.
//
// https://www.vecteezy.com/vector-art/550005-city-park-and-wooden-bench-thin-line-art-style-illustration-green-urban-public-park

import SwiftUI
import Lottie

struct WalkingSwipeView: View {
    
    @State var screenId = 0
    @State var shouldAnimateBottomPanel = false
    
    var backgroundColor: SwiftUI.Color {
        if screenId == 0 {
            return Color.green
        }
        if screenId == 1 {
            return Color.red
        }
            
        return Color.blue
    }
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea().animation(.easeInOut(duration: 1))
            WalkingBackgroundView(screenId: $screenId)
            PopUpTextView(screenId: $screenId)
            VStack {
                WalkingView(screenId: $screenId)
                    .frame(width: UIScreen.main.bounds.width, height: 600, alignment: .center)
                    .onTapGesture {
                        if screenId < 2 {
                            screenId += 1
                        }
                    }
                Spacer()
                BottomPanelView(screenId: $screenId)
            }.ignoresSafeArea()
        }
    }
}

struct PopUpTextView: View {
    
    @State var scale: CGFloat = 1
    @Binding var screenId: Int
    
    var body: some View {
        Text("Tap for another fact !")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .frame(width: 220)
            .offset(x: -20, y: -320)
            .scaleEffect(scale)
            .rotationEffect(Angle(degrees: 15))
            .shadow(color: .gray, radius: 4, x: 0, y: 0)
            .onAppear {
                withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                    scale = 1.05
                }
            }
            .onChange(of: screenId) { _ in
                scale = 0
                withAnimation(.easeInOut(duration: 0.8)) {
                    scale = 1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                        scale = 1.05
                    }
                }
            }
    }
}

struct BottomPanelView: View {
    
    @State var yOffset: CGFloat = 0
    @Binding var screenId: Int
    
    @State var titleText: String = "Avocado"
    @State var subtitleText: String = "In the summer of 2017, more than 3,000,000 photos of avocado toast were uploaded to Instagram every day."
    
    var body: some View {
        VStack {
            ZStack{
                Capsule()
                    .frame(width: 40, height: 6)
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            
            VStack(alignment: .leading) {
                Text(titleText)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                Text(subtitleText)
                    .font(.title2)
                    .padding(.bottom, 56)
                    .opacity(0.8)
                //Spacer()
            }.padding([.leading, .trailing], 34)
            
        }.frame(width: UIScreen.main.bounds.width, alignment: .leading)
            .background(Color.white.cornerRadius(30).shadow(color: Color.init(UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)), radius: 8, x: 0, y: -5))
            .offset(y: yOffset)
            .onChange(of: screenId) { _ in
                animate()
            }
    }
    
    func animate() {
        withAnimation(.easeInOut(duration: 0.5)) { yOffset = 300 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if screenId == 1 {
                titleText = "Fries lovers"
                subtitleText = "Americans eat more than 16 pounds of French fries every year, which comes to over 2 million tons!"
            } else {
                titleText = "Happy coffee"
                subtitleText = "While they do look a lot like beans, coffee “beans” are actually the seed, or pit, of the fruit that grows on coffee trees."
            }
        }
        withAnimation(.easeInOut(duration: 0.5).delay(0.5)) {
            yOffset = 0
        }
    }
}

struct WalkingBackgroundView: View {
    
    var imageWidth: CGFloat = 902.8
    @Binding var screenId: Int
    @State var isAnimating = false
    @State var offset1: CGFloat = 0
    @State var offset2: CGFloat = 902.8
    
    var body: some View {
        ZStack {
            Image("WalkingBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 412)
                .offset(x: offset1)
            Image("WalkingBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 412)
                .offset(x: offset2)
        }
        .offset(y: -180)
        .animation(Animation.linear(duration: 10).repeatForever(autoreverses: false))
        .opacity(0.5)
        .onAppear(perform: {
            isAnimating = true
            offset1 = -imageWidth
            offset2 = 0
        })
    }
}

struct WalkingView: View {
    
    @Binding var screenId: Int
    var xOffset = UIScreen.main.bounds.width * 2
    
    var walkingOffset: CGFloat {
        return CGFloat(screenId) * xOffset + 90
    }
    
    var body: some View {
        ZStack {
            LottieView(name: "walking-avocado", loopMode: .loop)
                .frame(width: 300, height: 300)
                .offset(x: -walkingOffset)
            LottieView(name: "french-fries", loopMode: .loop)
                .frame(width: 300, height: 300)
                .offset(x: 1.0 * xOffset - walkingOffset)
            LottieView(name: "coffee-time", loopMode: .loop)
                .frame(width: 300, height: 300)
                .offset(x: 2.0 * xOffset - walkingOffset)
        }.animation(.easeInOut(duration: 1))
            .offset(y: 150)
    }
}

struct WalkingSwipeView_Previews: PreviewProvider {
    static var previews: some View {
        WalkingSwipeView()
    }
}
