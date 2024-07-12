/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI
#if !SKIP
import AVFoundation
#endif

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    @StateObject var scrumTimer = ScrumTimer()
    #if !SKIP
    @StateObject var speechRecognizer = SpeechRecognizer()
    #endif
    @State private var isRecording = false

    #if !SKIP
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
    #endif

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, theme: scrum.theme)
                MeetingTimerView(speakers: scrumTimer.speakers, isRecording: isRecording, theme: scrum.theme)
                    #if SKIP
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    #endif
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .onAppear {
            startScrum()
        }
        .onDisappear {
            endScrum()
        }
        .navigationBarTitleDisplayMode(.inline)
        #if SKIP
        .toolbarBackground(.hidden, for: .navigationBar)
        #endif
    }
    
    private func startScrum() {
        scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
        scrumTimer.speakerChangedAction = {
            #if !SKIP
            player.seek(to: .zero)
            player.play()
            #endif
        }
        #if !SKIP
        speechRecognizer.resetTranscript()
        speechRecognizer.startTranscribing()
        #endif
        isRecording = true
        scrumTimer.startScrum()
    }
    
    private func endScrum() {
        scrumTimer.stopScrum()
        #if !SKIP
        speechRecognizer.stopTranscribing()
        #endif
        isRecording = false
        #if !SKIP
        let newHistory = History(attendees: scrum.attendees,
                                 transcript: speechRecognizer.transcript)
        #else
        let newHistory = History(attendees: scrum.attendees,
                                 transcript: "")
        #endif
        scrum.history.insert(newHistory, at: 0)
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
