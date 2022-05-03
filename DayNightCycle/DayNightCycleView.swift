//
//  DayNightCycleView.swift
//  Animations
//
//  Created by Loic D on 14/04/2022.
//

import SwiftUI
import Lottie

struct DayNightCycleView: View {
    
    private var animationView: AnimationView?
    private var lottieBackground = LottieView(name: "day-night-cycle", loopMode: .playOnce)
    @State var isDay: Bool = true
    
    var body: some View {
        
        ZStack {
            lottieBackground
                .ignoresSafeArea()
                .scaleEffect(1.15)
                .onAppear(perform: {
                    lottieBackground.pauseAnimation()
                })
            
            VStack{
                HStack {
                    TopContainerView(isDay: $isDay)
                    
                    Toggle("", isOn: $isDay)
                        .frame(width: 50, height: 100, alignment: .trailing)
                        .onChange(of: isDay) { _ in
                            lottieBackground.playCycle(isDay: isDay)
                        }
                } .padding([.top, .bottom], 20.0)
                
                ScheduleBannerContainerView(isDay: $isDay)
                Spacer()
                BottomView()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.leading, .trailing], 20)
        }
    }
}

struct TopContainerView: View {
    
    @Binding var isDay: Bool
    var screenWidth = UIScreen.main.bounds.width
    @State var dayOffset: CGFloat = 0
    @State var nightOffset: CGFloat = -UIScreen.main.bounds.width
    
    var body: some View {
        ZStack{
            // Day
            TopView(title: "Good Day, Sir", subtitle: "14 November, 2021")
                .offset(x: dayOffset)
                .opacity(isDay ? 1 : 0)
                .animation(.easeInOut(duration: 1.3))

            
            // Night
            TopView(title: "Good Night !", subtitle: "14 November, 2021")
                .offset(x: nightOffset)
                .opacity(isDay ? 0 : 1)
                .animation(.easeInOut(duration: 1.3))
        }
        .frame(width: 300, height: 100, alignment: .leading)
        .onChange(of: isDay) { _ in
            withAnimation(.easeInOut(duration: 1.3)) {
                dayOffset += screenWidth
                nightOffset += screenWidth
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                dayOffset = isDay ? dayOffset : -screenWidth
                nightOffset = isDay ? -screenWidth : nightOffset
            }
        }
    }
}

struct TopView: View {
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.bottom, 4)
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.white)
        }
    }
}

struct ScheduleBannerContainerView: View {
    
    @Binding var isDay: Bool
    var screenWidth = UIScreen.main.bounds.width
    @State var dayOffset: CGFloat = 0
    @State var nightOffset: CGFloat = -UIScreen.main.bounds.width
    
    var body: some View {
        
        ZStack {
            ScheduleBannerView(title: "Activities today", time: "9:00 a.m.", subtitle: "Fitness in Central Park")
            .offset(x: dayOffset)
            .opacity(isDay ? 1 : 0)
            .animation(.easeInOut(duration: 1).delay(0.3))

            // Night
            ScheduleBannerView(title: "Activities tonight", time: "8:30 p.m.", subtitle: "Meditation and relaxation")
            .offset(x: nightOffset)
            .opacity(isDay ? 0 : 1)
            .animation(.easeInOut(duration: 1).delay(0.3))
        }
        .onChange(of: isDay) { _ in
            withAnimation(.easeInOut(duration: 1).delay(0.3)) {
                dayOffset += screenWidth
                nightOffset += screenWidth
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                dayOffset = isDay ? dayOffset : -screenWidth
                nightOffset = isDay ? -screenWidth : nightOffset
            }
        }
    }
}

struct ScheduleBannerView: View {
    
    var title: String
    var time: String
    var subtitle: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "bell.fill")
                        .foregroundColor(.orange)
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.orange)
                
                Spacer()
                
                Text(time)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }.padding(.bottom, 4)
            Text(subtitle)
                .font(.subheadline)
        }.padding([.top, .bottom], 20).padding([.leading, .trailing], 24)
        .background(
            Color.white
            .cornerRadius(20)
            .shadow(color: Color.init(UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)), radius: 20, x: 0, y: 20)
        )
    }
}

struct BottomView: View {
        
    var body: some View {
        VStack(alignment: .leading) {
            Text("What do you need today ?")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            HStack {
                Image(systemName: "book")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .padding(.leading, 30)
                        .padding(.trailing, 18)
                VStack(alignment: .leading) {
                    Text("Time to read")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.bottom, 1)
                    Text("Recommanded in the morning")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }.padding([.top, .bottom], 20)
                Spacer()
            }
            .background(Color.init(UIColor(red: 0.1, green: 0.1, blue: 0.2, alpha: 0.6))            .cornerRadius(20))
        }
    }
}

struct DayNightCycleView_Previews: PreviewProvider {
    static var previews: some View {
        DayNightCycleView()
    }
}
