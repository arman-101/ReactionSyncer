import SwiftUI
import AVKit
import AppKit
import UniformTypeIdentifiers

struct ContentView: View {
    @State private var leftPlayer: AVPlayer? = nil
    @State private var rightPlayer: AVPlayer? = nil
    @State private var isVertical: Bool = false // Toggle state for layout
    
    private var bothVideosLoaded: Bool {
        leftPlayer != nil && rightPlayer != nil
    }
    
    private var isPlaying: Bool {
        leftPlayer?.rate != 0 && rightPlayer?.rate != 0
    }
    
    var body: some View {
        ZStack {
            Color(red: 1.0, green: 0.75, blue: 0.8) // Pink background color
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Video Players section
                ScrollView {
                    VStack(spacing: 20) {
                        if !isVertical {
                            HStack(spacing: 20) {
                                Spacer()
                                VStack {
                                    VideoPlayerView(player: leftPlayer)
                                        .frame(width: 640, height: 360) // 16:9 aspect ratio
                                        .border(Color.white, width: 4) // Thicker border
                                }
                                
                                VStack {
                                    VideoPlayerView(player: rightPlayer)
                                        .frame(width: 640, height: 360) // 16:9 aspect ratio
                                        .border(Color.white, width: 4) // Thicker border
                                }
                                Spacer()
                            }
                        } else {
                            VStack(spacing: 20) {
                                Spacer()
                                VideoPlayerView(player: leftPlayer)
                                    .frame(width: 640, height: 360) // 16:9 aspect ratio
                                    .border(Color.white, width: 4) // Thicker border
                                
                                VideoPlayerView(player: rightPlayer)
                                    .frame(width: 640, height: 360) // 16:9 aspect ratio
                                    .border(Color.white, width: 4) // Thicker border
                                Spacer()
                            }
                        }
                        
                        VStack {
                            HStack(spacing: 20) {
                                Button(action: {
                                    selectVideo { url in
                                        leftPlayer = AVPlayer(url: url)
                                        leftPlayer?.play()
                                    }
                                }) {
                                    Text(isVertical ? "Select Top Video" : "Select Left Video")
                                        .padding()
                                        .background(Color.blue.opacity(0.3)) // Light blue color
                                        .foregroundColor(.white)
                                        .clipShape(Rectangle()) // No rounded corners
                                        .overlay(Rectangle().stroke(Color.white, lineWidth: 2)) // White border
                                }
                                .buttonStyle(PlainButtonStyle()) // Ensure no extra styling
                                
                                Button(action: {
                                    skipTime(by: -300)
                                }) {
                                    Image(systemName: "gobackward")
                                        .font(.title)
                                        .frame(width: 50, height: 50) // Consistent button size
                                        .background(Color.blue.opacity(0.3)) // Light blue color
                                        .foregroundColor(.white)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.white, lineWidth: 2)) // White border
                                }
                                .buttonStyle(PlainButtonStyle()) // Ensure no extra styling
                                .opacity(bothVideosLoaded ? 1 : 0.5)
                                .disabled(!bothVideosLoaded)
                                
                                Button(action: {
                                    skipTime(by: -15)
                                }) {
                                    Image(systemName: "gobackward.15")
                                        .font(.title)
                                        .frame(width: 50, height: 50) // Consistent button size
                                        .background(Color.blue.opacity(0.3)) // Light blue color
                                        .foregroundColor(.white)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.white, lineWidth: 2)) // White border
                                }
                                .buttonStyle(PlainButtonStyle()) // Ensure no extra styling
                                .opacity(bothVideosLoaded ? 1 : 0.5)
                                .disabled(!bothVideosLoaded)
                                
                                Button(action: {
                                    togglePlayPause()
                                }) {
                                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                        .font(.title)
                                        .frame(width: 50, height: 50) // Consistent button size
                                        .background(Color.blue.opacity(0.3)) // Light blue color
                                        .foregroundColor(.white)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.white, lineWidth: 2)) // White border
                                }
                                .buttonStyle(PlainButtonStyle()) // Ensure no extra styling
                                .opacity(bothVideosLoaded ? 1 : 0.5)
                                .disabled(!bothVideosLoaded)
                                
                                Button(action: {
                                    skipTime(by: 15)
                                }) {
                                    Image(systemName: "goforward.15")
                                        .font(.title)
                                        .frame(width: 50, height: 50) // Consistent button size
                                        .background(Color.blue.opacity(0.3)) // Light blue color
                                        .foregroundColor(.white)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.white, lineWidth: 2)) // White border
                                }
                                .buttonStyle(PlainButtonStyle()) // Ensure no extra styling
                                .opacity(bothVideosLoaded ? 1 : 0.5)
                                .disabled(!bothVideosLoaded)
                                
                                Button(action: {
                                    skipTime(by: 300)
                                }) {
                                    Image(systemName: "goforward")
                                        .font(.title)
                                        .frame(width: 50, height: 50) // Consistent button size
                                        .background(Color.blue.opacity(0.3)) // Light blue color
                                        .foregroundColor(.white)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.white, lineWidth: 2)) // White border
                                }
                                .buttonStyle(PlainButtonStyle()) // Ensure no extra styling
                                .opacity(bothVideosLoaded ? 1 : 0.5)
                                .disabled(!bothVideosLoaded)
                                
                                Button(action: {
                                    selectVideo { url in
                                        rightPlayer = AVPlayer(url: url)
                                        rightPlayer?.play()
                                    }
                                }) {
                                    Text(isVertical ? "Select Bottom Video" : "Select Right Video")
                                        .padding()
                                        .background(Color.blue.opacity(0.3)) // Light blue color
                                        .foregroundColor(.white)
                                        .clipShape(Rectangle()) // No rounded corners
                                        .overlay(Rectangle().stroke(Color.white, lineWidth: 2)) // White border
                                }
                                .buttonStyle(PlainButtonStyle()) // Ensure no extra styling
                            }
                            
                            // Vertical/Horizontal Toggle
                            HStack {
                                Spacer()
                                Button(action: {
                                    isVertical.toggle() // Toggle between vertical and horizontal
                                }) {
                                    Text(isVertical ? "Horizontal" : "Vertical")
                                        .padding()
                                        .background(Color.red.opacity(0.3)) // Light red color
                                        .foregroundColor(.white)
                                        .clipShape(Rectangle()) // No rounded corners
                                        .overlay(Rectangle().stroke(Color.white, lineWidth: 2)) // White border
                                }
                                .buttonStyle(PlainButtonStyle()) // Ensure no extra styling
                                .padding(.top, 20) // Add padding above
                                Spacer()
                            }
                            .padding(.top, 20) // Additional padding to ensure top alignment
                        }
                        .padding()
                    }
                    .padding(.top, 20) // Add padding at the top
                }
                .padding(.top, 20) // Additional padding to ensure top alignment
            }
        }
    }
    
    private func togglePlayPause() {
        guard bothVideosLoaded else { return }
        
        if isPlaying {
            leftPlayer?.pause()
            rightPlayer?.pause()
        } else {
            leftPlayer?.play()
            rightPlayer?.play()
        }
    }
    
    private func skipTime(by seconds: Double) {
        guard bothVideosLoaded else { return }
        
        leftPlayer?.seek(to: CMTime(seconds: CMTimeGetSeconds(leftPlayer!.currentTime()) + seconds, preferredTimescale: 1))
        rightPlayer?.seek(to: CMTime(seconds: CMTimeGetSeconds(rightPlayer!.currentTime()) + seconds, preferredTimescale: 1))
    }
    
    private func selectVideo(completion: @escaping (URL) -> Void) {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.allowedContentTypes = [.movie, .audio]
        
        if panel.runModal() == .OK {
            if let url = panel.url {
                completion(url)
            }
        }
    }
}

struct VideoPlayerView: NSViewRepresentable {
    let player: AVPlayer?
    
    func makeNSView(context: Context) -> AVPlayerView {
        let playerView = AVPlayerView()
        playerView.controlsStyle = .floating
        playerView.allowsPictureInPicturePlayback = true
        return playerView
    }
    
    func updateNSView(_ nsView: AVPlayerView, context: Context) {
        nsView.player = player
    }
}
