# Test Notifications Walkthrough

The "Test Notifications" feature has been successfully implemented in the dashboard. You can now send live push notifications exclusively to selected devices to see how they look before sending them to your entire user base.

## What Was Done

1. **Database Update:** Created a new `test_devices` table in the database to securely store the names and FCM Tokens of your test devices.
2. **Backend Endpoints:** Added new endpoints to your FastAPI backend to support adding/deleting test devices, as well as a specialized `POST /notifications/send-test` endpoint that bypasses the general topic broadcasting and uses Firebase's Multicast Messaging to send directly to specific tokens.
3. **Dashboard Interface:** 
   - Added a **"Manage Test Devices"** card in the Notifications dashboard where you can easily save or delete test devices.
   - Updated the **"Send Notification"** form to include a checkbox list of your saved Test Devices.
   - Added an orange **"Send TEST"** button right next to the red **"Send to Topic (ALL)"** button.

## How to use the feature

1. Go to the Notifications page in the Dashboard.
2. Under "Manage Test Devices", add a new device by giving it a recognizable name (e.g., "Developer's iPhone") and pasting its FCM Token.
3. When you are ready to send a test notification, fill out the Message Title and Body as usual.
4. Check the boxes next to the Test Devices you want to receive the notification.
5. Click **"Send TEST"**. The notification will go *only* to those devices and will *not* be recorded in the global history.

---

## Developer Guide: How to Get the FCM Token

> [!IMPORTANT]
> Forward these instructions to your Mobile App Developer so they can provide you with the necessary FCM Tokens for your test devices.

To add a device to the "Manage Test Devices" dashboard, you need that specific device's **FCM Registration Token**. The mobile app needs to retrieve this token and surface it so you can copy it.

### Suggestion for the Developer

The easiest solution is for the developer to add a hidden "Developer Menu" or a simple gesture (e.g., tapping the app version number 5 times in the settings screen) that fetches the FCM Token and either copies it to the clipboard or opens an email composer.

#### Code Snippet for iOS (Swift)
If the app uses Firebase Messaging on iOS:
```swift
Messaging.messaging().token { token, error in
  if let error = error {
    print("Error fetching FCM registration token: \(error)")
  } else if let token = token {
    print("FCM registration token: \(token)")
    // Add logic here to copy the token to the clipboard 
    // UIPasteboard.general.string = token
    // OR display it in an alert / email it.
  }
}
```

#### Code Snippet for Android (Kotlin)
If the app uses Firebase Messaging on Android:
```kotlin
FirebaseMessaging.getInstance().token.addOnCompleteListener(OnCompleteListener { task ->
    if (!task.isSuccessful) {
        Log.w(TAG, "Fetching FCM registration token failed", task.exception)
        return@OnCompleteListener
    }
    // Get new FCM registration token
    val token = task.result
    Log.d(TAG, "FCM Token: $token")
    // Add logic here to copy to clipboard or display to the user
})
```

Once the developer implements a way to copy these long tokens, you can simply paste them into the "FCM Token" input in the dashboard and start sending test pushes!
