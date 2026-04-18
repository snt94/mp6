//
//  MusicScannerService.swift
//  mp6
//
//  Created by iOSLab on 18/04/26.
//


import Foundation
import AVFoundation

class MusicScannerService {
    
    private let supportedExtensions = ["mp3", "m4a", "aac", "wav", "flac", "aiff"]

    /// Varre uma pasta e retorna os arquivos de música encontrados
    func scanFolder(at folderURL: URL) async throws -> [MusicFile] {
        // Garante acesso à pasta selecionada (Security Scoped Resource)
        guard folderURL.startAccessingSecurityScopedResource() else {
            throw ScanError.accessDenied
        }
        defer { folderURL.stopAccessingSecurityScopedResource() }

        let fileManager = FileManager.default

        // Busca recursiva na pasta
        guard let enumerator = fileManager.enumerator(
            at: folderURL,
            includingPropertiesForKeys: [.fileSizeKey, .isRegularFileKey],
            options: [.skipsHiddenFiles]
        ) else {
            throw ScanError.cannotReadFolder
        }

        var musicFiles: [MusicFile] = []

        for case let fileURL as URL in enumerator {
            let ext = fileURL.pathExtension.lowercased()
            guard supportedExtensions.contains(ext) else { continue }

            if let musicFile = await extractMetadata(from: fileURL) {
                musicFiles.append(musicFile)
            }
        }

        return musicFiles.sorted { $0.title < $1.title }
    }

    /// Extrai metadados de um arquivo usando AVAsset
    private func extractMetadata(from url: URL) async -> MusicFile? {
        let asset = AVURLAsset(url: url)

        let fileSize = (try? url.resourceValues(forKeys: [.fileSizeKey]).fileSize)
            .flatMap { Int64($0) } ?? 0


        let duration: TimeInterval
        do {
            let cmDuration = try await asset.load(.duration)
            duration = CMTimeGetSeconds(cmDuration)
        } catch {
            duration = 0
        }


        var title = url.deletingPathExtension().lastPathComponent
        var artist = "Desconhecido"
        var album = "Desconhecido"

        do {
            let metadata = try await asset.load(.commonMetadata)
            for item in metadata {
                guard let key = item.commonKey else { continue }
                switch key {
                case .commonKeyTitle:
                    if let value = try? await item.load(.stringValue) { title = value }
                case .commonKeyArtist:
                    if let value = try? await item.load(.stringValue) { artist = value }
                case .commonKeyAlbumName:
                    if let value = try? await item.load(.stringValue) { album = value }
                default:
                    break
                }
            }
        } catch { }

        return MusicFile(
            url: url,
            title: title,
            artist: artist,
            album: album,
            duration: duration,
            fileSize: fileSize
        )
    }

    enum ScanError: LocalizedError {
        case accessDenied
        case cannotReadFolder

        var errorDescription: String? {
            switch self {
            case .accessDenied:      return "Permissão negada para acessar a pasta."
            case .cannotReadFolder:  return "Não foi possível ler o conteúdo da pasta."
            }
        }
    }
}
