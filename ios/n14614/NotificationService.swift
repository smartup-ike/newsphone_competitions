//
//  NotificationService.swift
//  n14614
//
//  Created by Dimitris Milios on 1/7/26.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(
        _ request: UNNotificationRequest,
        withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void
    ) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)

        guard let bestAttemptContent = bestAttemptContent else {
            contentHandler(request.content)
            return
        }

        // Look for the image URL in the FCM payload.
        // Firebase Console sends it under "fcm_options" → "image", or directly in "image".
        let userInfo = request.content.userInfo
        var imageURLString: String? = nil

        if let fcmOptions = userInfo["fcm_options"] as? [String: Any],
           let imageURL = fcmOptions["image"] as? String {
            imageURLString = imageURL
        } else if let imageURL = userInfo["image"] as? String {
            imageURLString = imageURL
        } else if let imageURL = userInfo["image_url"] as? String {
            imageURLString = imageURL
        }

        guard let urlString = imageURLString, let url = URL(string: urlString) else {
            // No image URL found — deliver notification as-is
            contentHandler(bestAttemptContent)
            return
        }

        downloadImage(from: url) { attachment in
            if let attachment = attachment {
                bestAttemptContent.attachments = [attachment]
            }
            contentHandler(bestAttemptContent)
        }
    }

    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Deliver the best attempt content with whatever we have so far.
        if let contentHandler = contentHandler, let bestAttemptContent = bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

    // MARK: - Helper

    private func downloadImage(from url: URL, completion: @escaping (UNNotificationAttachment?) -> Void) {
        let task = URLSession.shared.downloadTask(with: url) { location, _, error in
            guard let location = location, error == nil else {
                completion(nil)
                return
            }

            // More robust file extension matching for Firebase URLs containing queries/slashes
            var ext = "jpg"
            let pathLower = url.path.lowercased()
            if pathLower.contains(".png") {
                ext = "png"
            } else if pathLower.contains(".gif") {
                ext = "gif"
            } else if pathLower.contains(".jpeg") {
                ext = "jpeg"
            }
            
            guard let cachesDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
                completion(nil)
                return
            }
            let destURL = cachesDir.appendingPathComponent(UUID().uuidString).appendingPathExtension(ext)

            do {
                try FileManager.default.moveItem(at: location, to: destURL)
                let attachment = try UNNotificationAttachment(identifier: UUID().uuidString, url: destURL)
                completion(attachment)
            } catch {
                completion(nil)
            }
        }
        task.resume()
    }
}
