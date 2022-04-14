//
//  ExtensionOnView.swift
//  RoddiMobileMusic
//
//  Created by Simbarashe Dombodzvuku on 3/29/22.
//

import Foundation
import SwiftUI

 extension View {
     //using the custom RoundedCorner Shape
     func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
             clipShape( RoundedCorner(radius: radius, corners: corners) )
     }
     
     //Extending view to get screen size
     func getRect() -> CGRect {
         return UIScreen.main.bounds
     }
     
     //Safe Area Value
     func safeArea() -> UIEdgeInsets {
         guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
             return .zero
         }
         
         guard let safeArea = screen.windows.first?.safeAreaInsets else {
             return .zero
         }
         
         return safeArea
     }
     
     //ScrollView offset
     func offset(offset: Binding<CGFloat>) -> some View {
         return self
             .overlay {
                 GeometryReader{ geometry in
                     let minY = geometry.frame(in: .named("SCROLL")).minY
                     
                     Color.clear
                         .preference(key: OffsetKey.self, value: minY)
                 }
                 .onPreferenceChange(OffsetKey.self) { value in
                     offset.wrappedValue = value
                 }
             }
     }
     
     func glow(color: Color = .red, radius: CGFloat = 20) -> some View {
         self
             .overlay(self.blur(radius: radius / 6))
             .shadow(color: color, radius: radius / 3)
             .shadow(color: color, radius: radius / 3)
             .shadow(color: color, radius: radius / 3)
     }
 }

 struct RoundedCorner: Shape {

     var radius: CGFloat = .infinity
     var corners: UIRectCorner = .allCorners

     func path(in rect: CGRect) -> Path {
         let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         return Path(path.cgPath)
     }
 }
