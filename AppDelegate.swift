import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        if let window = NSApplication.shared.windows.first {
            // Obtain the screen size
            if let screen = NSScreen.main {
                let screenFrame = screen.frame
                let aspectRatio: CGFloat = 16 / 9
                
                // Calculate the window size based on screen height
                let newHeight = screenFrame.height
                let newWidth = newHeight * aspectRatio
                
                // Ensure the width does not exceed screen width
                let finalWidth: CGFloat
                let finalHeight: CGFloat
                
                if newWidth > screenFrame.width {
                    finalWidth = screenFrame.width
                    finalHeight = finalWidth / aspectRatio
                } else {
                    finalWidth = newWidth
                    finalHeight = newHeight
                }
                
                // Center the window
                let xPosition = (screenFrame.width - finalWidth) / 2
                let yPosition = (screenFrame.height - finalHeight) / 2
                
                window.setFrame(NSRect(x: xPosition, y: yPosition, width: finalWidth, height: finalHeight), display: true, animate: true)
            }
        }
    }
}
