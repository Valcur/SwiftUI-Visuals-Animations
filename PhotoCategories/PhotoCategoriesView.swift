//
//  PhotoCategoriesView.swift
//  Animations
//
//  Created by Loic D on 16/04/2022.
//

import SwiftUI
import Lottie

struct PhotoCategoriesView: View {
    
    @State var imageFocused: Int = -1
    @Namespace private var animation
    var screenHeight = UIScreen.main.bounds.height
    var screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black
            
            PhotoView(imageId: 0, imageFocused: $imageFocused, animation: animation)
            PhotoView(imageId: 1, imageFocused: $imageFocused, animation: animation)
            PhotoView(imageId: 2, imageFocused: $imageFocused, animation: animation)
            PhotoView(imageId: 3, imageFocused: $imageFocused, animation: animation)
            
            PhotoGestureDetectionView(imageId: 0, imageFocused: $imageFocused)
            PhotoGestureDetectionView(imageId: 1, imageFocused: $imageFocused)
            PhotoGestureDetectionView(imageId: 2, imageFocused: $imageFocused)
            PhotoGestureDetectionView(imageId: 3, imageFocused: $imageFocused)
            
            if imageFocused != -1 {
                VStack {
                    ZStack{
                        Capsule()
                            .frame(width: 40, height: 6)
                            .foregroundColor(.gray)
                    }
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .offset(x: -35)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Photos")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.bottom, 8)
                            Spacer()
                            Text("Likes")
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.bottom, 8)
                                .foregroundColor(.gray)
                            Spacer()
                            Text("Collection")
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.bottom, 8)
                                .foregroundColor(.gray)
                        }.padding([.leading, .trailing], 40).padding(.bottom, 16)
                        
                        HStack(spacing: 32) {
                            Image("Pic1")
                                .resizable()
                                .frame(width: 200, height: 200)
                                .cornerRadius(20)
                                .shadow(color: Color.init(UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)), radius: 8, x: 0, y: -5)
                            Image("Pic2")
                                .resizable()
                                .frame(width: 200, height: 200)
                                .cornerRadius(20)
                                .shadow(color: Color.init(UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)), radius: 8, x: 0, y: -5)
                        }.padding([.leading, .trailing], 24).padding(.bottom, 64)
                    }
                    
                }.frame(width: UIScreen.main.bounds.width, alignment: .leading)
                    .background(Color.white.cornerRadius(30).shadow(color: Color.init(UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)), radius: 8, x: 0, y: 5))
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut(duration: 0.3).delay(0.1))
            }
        }.ignoresSafeArea()
    }
}

struct PhotoView: View {
    
    var imageId: Int
    var viewHeight: CGFloat = UIScreen.main.bounds.height / 4
    var screenHeight = UIScreen.main.bounds.height
    var screenWidth = UIScreen.main.bounds.width
    @Binding var imageFocused: Int
    let animation: Namespace.ID
    @State private var fontSize: CGFloat = 20
    @State private var fontWeight: Font.Weight = .semibold
    @State private var fontPosX: CGFloat = 0
    @State private var fontposY: CGFloat = 0
    
    var photoTitle: String {
        if imageId == 0 {
            return "Anne McCarthy"
        } else if imageId == 1 {
            return "Matteo Badini"
        } else if imageId == 2 {
            return "S Migaj"
        }
        return "Michael Block"
    }
    
    var body: some View {
        ZStack {
            Image("Pic\(imageId)")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame( width: screenWidth, height: screenHeight)
                .mask(getImageMaskShape())
                .scaleEffect(imageFocused == imageId ? 1.4 : 1)
                .animation(.easeInOut(duration: 0.5))
                Text(photoTitle)
                    .foregroundColor(.white)
                    .frame(width: screenWidth, height: 100, alignment: .leading)
                    .opacity(imageFocused == imageId || imageFocused == -1 ? 1 : 0)
                    .animatableSystemFont(size: fontSize, weight: fontWeight)
                    .offset(x: fontPosX, y: fontposY)
        }
            .frame(width: screenWidth, height: screenHeight)
            .onChange(of: imageFocused) { _ in
                if imageFocused == imageId {
                    withAnimation(.spring(response: 0.5, dampingFraction: 1, blendDuration: 0.5)) {
                        fontSize = 50
                        fontWeight = .bold
                        fontPosX = 30
                        fontposY = -300
                    }
                } else if imageFocused == -1 {
                    withAnimation(.spring(response: 0.5, dampingFraction: 1, blendDuration: 0.5)) {
                        fontSize = 20
                        fontWeight = .semibold
                        fontPosX = 15
                        fontposY = -30 - viewHeight + CGFloat(imageId) * viewHeight
                    }
                }
            }
            .onAppear {
                fontPosX = 15
                fontposY = -30 - viewHeight + CGFloat(imageId) * viewHeight
            }
    }
    
    func getImageMaskShape() -> some View {
        if imageFocused == imageId {
            return Rectangle().padding(.top, 0).padding(.bottom, 0)
        } else if imageFocused != -1 && imageId < imageFocused {
            return Rectangle().padding(.top, 0).padding(.bottom, screenHeight)
        } else if imageFocused != -1 && imageId >= imageFocused {
            return Rectangle().padding(.top, screenHeight).padding(.bottom, 0)
        }
        return Rectangle().padding(.top, CGFloat(imageId) * viewHeight).padding(.bottom, (3 - CGFloat(imageId)) * viewHeight)
    }
}

struct PhotoGestureDetectionView: View {
    
    var imageId: Int
    var viewHeight: CGFloat = UIScreen.main.bounds.height / 4
    var screenHeight = UIScreen.main.bounds.height
    var screenWidth = UIScreen.main.bounds.width
    @Binding var imageFocused: Int
    
    var body: some View {

        Rectangle().frame(width: screenWidth, height: viewHeight).position(x: screenWidth / 2, y: viewHeight / 2 + CGFloat(imageId) * viewHeight).opacity(0.00001).zIndex(1000)
            .onTapGesture {
                if imageFocused == -1 {
                    imageFocused = imageId
                } else {
                    imageFocused = -1
                }
        }
    }
}

struct PhotoCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCategoriesView()
    }
}

struct AnimatableSystemFontModifier: AnimatableModifier {
    var size: CGFloat
    var weight: Font.Weight
    var design: Font.Design

    var animatableData: CGFloat {
        get { size }
        set { size = newValue }
    }

    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: weight, design: design))
    }
}

extension View {
    func animatableSystemFont(size: CGFloat, weight: Font.Weight = .regular, design: Font.Design = .default) -> some View {
        self.modifier(AnimatableSystemFontModifier(size: size, weight: weight, design: design))
    }
}
