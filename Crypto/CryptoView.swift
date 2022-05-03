//
//  CryptoView.swift
//  Animations
//
//  Created by Loic D on 18/04/2022.
//

import SwiftUI

struct CryptoView: View {
  
    var body: some View {
        ZStack {
            Color("BackgroundDarkColor")
            Circle()
                .frame(width: 160, height: 160)
                .position(x: UIScreen.main.bounds.width - 50, y: 20)
                .foregroundColor(Color("CircleColorDark"))
            Circle()
                .frame(width: 60, height: 60)
                .position(x: UIScreen.main.bounds.width - 100, y: 85)
                .foregroundColor(Color("CircleColorLight"))
            VStack{
                HStack(spacing: 20)  {
                    Image(systemName: "arrow.backward")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 20, height: 20)
                    Text("My Portfolio")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Spacer()
                }
                    .padding(.top, 60).padding(.bottom, 20).padding(.leading, 25)
                
                HStack(spacing: 50) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Deposit")
                            .font(.title2)
                            .foregroundColor(.gray)
                        Text("$5,100")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Rate")
                            .font(.title2)
                            .foregroundColor(.gray)
                        Text("+12.50%")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
                }
                
                GraphPanelView()
                
                CryptoBottomView()
            }
        }.ignoresSafeArea().preferredColorScheme(.dark)
    }
}

struct GraphPanelView: View {
  
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [4.295]))
                    .foregroundColor(.gray)
                    .opacity(0.3)
                    .frame(height: 1)
                    .offset(y: -40)
                Rectangle()
                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [4.295]))
                    .foregroundColor(.gray)
                    .opacity(0.3)
                    .frame(height: 1)
                    .offset(y: 55)
                GraphView()
                ZStack {
                    Circle()
                        .foregroundColor(Color("BackgroundDarkColor"))
                        .frame(width: 25, height: 25)
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 15, height: 15)
                }.offset(x: 45, y: -15)
                Text("$5,683")
                    .foregroundColor(Color("BackgroundDarkColor"))
                    .font(.title3)
                    .background(Color(.white).frame(width: 100, height: 40).cornerRadius(8))
                    .offset(x: -25, y: -50)
            }
            HStack(alignment: .bottom, spacing: 6) {
                GraphBarView(barValue: 2)
                GraphBarView(barValue: 2)
                GraphBarView(barValue: 4)
                GraphBarView(barValue: 2)
                GraphBarView(barValue: 1)
                GraphBarView(barValue: 1)
                GraphBarView(barValue: 3)
                GraphBarView(barValue: 2)
                GraphBarView(barValue: 6)
                GraphBarView(barValue: 2)
            }.frame(height: 70).padding(.bottom, 20).offset(x: -10)
            HStack(spacing: 8) {
                GraphTimeSelectorView(textString: "1h", isSelected: false)
                GraphTimeSelectorView(textString: "24h", isSelected: true)
                GraphTimeSelectorView(textString: "1w", isSelected: false)
                GraphTimeSelectorView(textString: "1y", isSelected: false)
                GraphTimeSelectorView(textString: "1m", isSelected: false)
                GraphTimeSelectorView(textString: "All", isSelected: false)
            }
        }
    }
}

struct GraphView: View {
    
    var graphValues: [CGFloat] = [1, 2, 5, 4, 7, 8, 12, 10, 9]
    var pointWidth: CGFloat = 47
    var pointHeight: CGFloat = -15.0
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                path.move(to: .init(x: graphValues[0], y: graphValues[0] * pointHeight))
                var previousPoint = 0
                for i in 1..<graphValues.count {
                    let x = CGFloat(i) * pointWidth
                    let y = graphValues[i] * pointHeight
                    
                    let deltaX = x - CGFloat(previousPoint) * pointWidth
                    let curveXOffset = deltaX * 0.5
                    
                    path.addCurve(to: .init(x: x, y: y),
                                  control1: .init(x: CGFloat(previousPoint) * pointWidth + curveXOffset, y: graphValues[previousPoint] * pointHeight),
                                  control2: .init(x: x - curveXOffset, y: y))
                    
                    previousPoint = i
                }
            }
            .stroke(
                Color("CryptoCyanColor"),
                style: StrokeStyle(lineWidth: 6)
            )
            .offset(y: geometry.size.height + 15)
        }
    }
}

struct GraphBarView: View {
    
    var barValue: CGFloat
    @State var barHeightPerValue: CGFloat = 10
    
    var body: some View {
        Color.gray
            .frame(width: 33, height: barValue * barHeightPerValue)
            .cornerRadius(5)
            .opacity(0.3)
    }
}

struct CryptoBottomView: View {
    
    var body: some View {
        ZStack {
            Color("BackgroundLightColor")
                .cornerRadius(30)
            VStack(spacing: 15) {
                ZStack{
                    Capsule()
                        .frame(width: 40, height: 6)
                        .foregroundColor(.gray)
                        .opacity(0.5)
                }
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                CryptoLineView(imageName: "BTC-icon", title: "BTC", titleValue: "$22.19", subtitle: "0.4827", subtitleValue: "+2.30%", isValuePositive: true)
                CryptoLineView(imageName: "XRP-icon", title: "XRP", titleValue: "$2.14", subtitle: "78.2123", subtitleValue: "-5.30%", isValuePositive: false)
            }.padding([.leading, .trailing, .bottom], 20)
        }.padding(15).padding(.top, 28).padding(.bottom, 38)
            .frame(height: 280)
    }
}

struct CryptoLineView: View {
    
    var imageName: String
    var title: String
    var titleValue: String
    var subtitle: String
    var subtitleValue: String
    var isValuePositive: Bool
    
    var body: some View {
        HStack(spacing: 20) {
            ZStack {
                Rectangle()
                    .foregroundColor(Color.gray)
                    .cornerRadius(20)
                    .opacity(0.2)
                    .frame(width: 70, height: 70)
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .foregroundColor(.white)
                    .font(.title3)
                    .fontWeight(.semibold)
                Text(subtitle)
                    .foregroundColor(.gray)
                    .font(.title3)
            }
            Spacer()
            VStack(alignment: .leading, spacing: 8) {
                Text(titleValue)
                    .foregroundColor(.white)
                    .font(.title3)
                    .fontWeight(.semibold)
                Text(subtitleValue)
                    .foregroundColor(isValuePositive ? Color("CryptoCyanColor") : Color("CryptoRedColor"))
                    .font(.title3)
            }
        }
    }
}

struct GraphTimeSelectorView: View {
    
    var textString: String
    var isSelected: Bool
    
    var body: some View {
        HStack {
            Text(textString)
                .foregroundColor(isSelected ? Color("BackgroundDarkColor") : .white)
                .frame(width: 56, height: 70)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.gray, lineWidth: isSelected ? 0 : 1)
                        .opacity(0.4)
                )
                .background() {
                    if isSelected {
                        Color("CryptoOrangeColor").cornerRadius(20)
                    }
                }
        }
    }
}

struct CryptoView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoView()
    }
}
