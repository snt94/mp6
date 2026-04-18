import SwiftUI

struct MusicLibraryView: View {

    @State private var musicFiles: [MusicFile] = []
    @State private var isShowingPicker = false
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var selectedFolderName: String?

    private let scanner = MusicScannerService()

    var body: some View {
        NavigationStack {
            Group {
                if isLoading {
                    loadingView
                } else if musicFiles.isEmpty {
                    emptyStateView
                } else {
                    musicListView
                }
            }
            .navigationTitle("Biblioteca")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isShowingPicker = true
                    } label: {
                        Label("Selecionar Pasta", systemImage: "folder.badge.plus")
                    }
                }
            }
            // ✅ Seletor de pasta nativo do iOS/macOS
            .fileImporter(
                isPresented: $isShowingPicker,
                allowedContentTypes: [.folder],
                allowsMultipleSelection: false
            ) { result in
                handleFolderSelection(result)
            }
            .alert("Erro", isPresented: .constant(errorMessage != nil)) {
                Button("OK") { errorMessage = nil }
            } message: {
                Text(errorMessage ?? "")
            }
        }
    }

    // MARK: - Subviews

    private var loadingView: some View {
        VStack(spacing: 12) {
            ProgressView()
            Text("Buscando músicas...")
                .foregroundStyle(.secondary)
        }
    }

    private var emptyStateView: some View {
        ContentUnavailableView(
            "Nenhuma música",
            systemImage: "music.note.list",
            description: Text("Toque em \(Image(systemName: "folder.badge.plus")) para selecionar uma pasta.")
        )
    }

    private var musicListView: some View {
        List(musicFiles) { music in
            MusicRowView(music: music)
        }
        .listStyle(.insetGrouped)
        .navigationSubtitle("\(musicFiles.count) música(s) • \(selectedFolderName ?? "")")
    }

    // MARK: - Actions

    private func handleFolderSelection(_ result: Result<[URL], Error>) {
        switch result {
        case .success(let urls):
            guard let folderURL = urls.first else { return }
            selectedFolderName = folderURL.lastPathComponent
            scanFolder(folderURL)
        case .failure(let error):
            errorMessage = error.localizedDescription
        }
    }

    private func scanFolder(_ url: URL) {
        isLoading = true
        musicFiles = []

        Task {
            do {
                let files = try await scanner.scanFolder(at: url)
                await MainActor.run {
                    musicFiles = files
                    isLoading = false
                }
            } catch {
                await MainActor.run {
                    errorMessage = error.localizedDescription
                    isLoading = false
                }
            }
        }
    }
}

// MARK: - Row

struct MusicRowView: View {
    let music: MusicFile

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "music.note")
                .font(.title2)
                .foregroundStyle(.accent)
                .frame(width: 40)

            VStack(alignment: .leading, spacing: 2) {
                Text(music.title)
                    .font(.body)
                    .fontWeight(.medium)
                    .lineLimit(1)

                Text(music.artist)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text(music.formattedDuration)
                    .font(.subheadline.monospacedDigit())

                Text(music.formattedSize)
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
        }
        .padding(.vertical, 4)
    }
}