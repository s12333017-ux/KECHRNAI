# Smart Kitchen AI - Android APK Build Guide

## 📋 Prerequisites Installation

### Step 1: Install Node.js

1. Download Node.js (v18 or higher) from: https://nodejs.org/
2. Download the **Windows Installer (.msi)** - choose LTS version
3. Run the installer and follow the installation wizard
4. **Important:** Check the box "Automatically install necessary tools"
5. Restart your computer after installation
6. Verify installation:
   ```powershell
   node --version
   npm --version
   ```

### Step 2: Install Java Development Kit (JDK)

1. Download JDK 17 from: https://adoptium.net/
2. Click "Latest LTS Release" and download **Windows x64 .msi**
3. Run the installer
4. **Important:** Check "Set JAVA_HOME variable" and "Add to PATH" during installation
5. Restart your computer
6. Verify installation:
   ```powershell
   java -version
   ```

### Step 3: Install Android Studio

1. Download Android Studio from: https://developer.android.com/studio
2. Run the installer (approximately 1GB download)
3. During installation:
   - Choose "Standard" installation
   - Accept all license agreements
   - Wait for SDK downloads to complete (~3-5GB)
4. After installation:
   - Open Android Studio
   - Go to **File → Settings → Appearance & Behavior → System Settings → Android SDK**
   - In **SDK Platforms** tab, ensure **Android 13 (API 33)** is installed
   - In **SDK Tools** tab, ensure these are checked:
     - Android SDK Build-Tools
     - Android SDK Command-line Tools
     - Android SDK Platform-Tools
     - Android Emulator (optional, for testing)
   - Click "Apply" to install missing components
5. Set environment variables:
   - Open Windows Start → Search "Environment Variables"
   - Click "Environment Variables..."
   - Under "User variables", click "New":
     - Variable name: `ANDROID_HOME`
     - Variable value: `C:\Users\YourUsername\AppData\Local\Android\Sdk`
   - Edit "Path" variable and add:
     - `%ANDROID_HOME%\platform-tools`
     - `%ANDROID_HOME%\tools\bin`
   - Click "OK" to save
6. Restart your computer again

---

## 🚀 Building the APK

Once all prerequisites are installed, follow these steps:

### Step 1: Install Dependencies

Open PowerShell in the project folder and run:

```powershell
npm install
```

This will install Capacitor and all required plugins (~5 minutes).

### Step 2: Initialize Capacitor

Run the initialization command:

```powershell
npx @capacitor/cli init "Smart Kitchen AI" "com.smartkitchen.ai" --web-dir="."
```

### Step 3: Add Android Platform

Add the Android platform to your project:

```powershell
npx cap add android
```

This creates the `android` folder with the complete Android Studio project.

### Step 4: Sync Web Files

Sync your web app files to the Android project:

```powershell
npx cap sync
```

This copies `index.html` and all related files to the Android project.

### Step 5: Build APK

#### Option A: Build via Command Line (Faster)

```powershell
cd android
.\gradlew assembleDebug
```

The APK will be generated at:
```
android\app\build\outputs\apk\debug\app-debug.apk
```

#### Option B: Build via Android Studio (More Control)

1. Open Android Studio
2. Click **File → Open** and select the `android` folder
3. Wait for Gradle sync to complete (~2-3 minutes first time)
4. Click **Build → Build Bundle(s) / APK(s) → Build APK(s)**
5. Wait for build to complete
6. Click "locate" in the success notification to find your APK

---

## 📱 Installing the APK

### On Physical Android Device:

1. Connect your Android phone via USB
2. Enable **Developer Options** on your phone:
   - Go to Settings → About Phone
   - Tap "Build Number" 7 times
   - Go back to Settings → Developer Options
   - Enable "USB Debugging"
3. Allow the USB debugging prompt on your phone
4. Install the APK:
   ```powershell
   adb install android\app\build\outputs\apk\debug\app-debug.apk
   ```

### On Android Emulator:

1. Open Android Studio
2. Click **Tools → Device Manager**
3. Click "Create Device"
4. Select a phone model (e.g., Pixel 5)
5. Select system image (e.g., Android 13 - API 33)
6. Click "Finish"
7. Click the play button to start the emulator
8. Drag and drop the APK file onto the emulator

---

## 🎯 Quick Setup Script

For convenience, after installing prerequisites, you can run:

```powershell
npm run setup
```

This runs all initialization commands in sequence.

---

## ⚠️ Troubleshooting

### "node is not recognized"
- Node.js is not installed or not in PATH
- Reinstall Node.js and restart computer

### "java is not recognized"
- JDK is not installed or not in PATH
- Reinstall JDK and ensure "Add to PATH" is checked

### "ANDROID_HOME is not set"
- Environment variable not configured
- Follow Step 3, section 5 above

### "Gradle build failed"
- Open Android Studio and let it auto-fix issues
- Go to **File → Invalidate Caches → Invalidate and Restart**

### "Could not find or load main class"
- JDK version mismatch
- Install JDK 17 specifically

### Build still failing?
- Delete `android` folder
- Run `npx cap add android` again
- Try building through Android Studio instead

---

## 📦 File Size

The generated APK will be approximately **50-90 MB** (debug build).

For a smaller release build (production):
```powershell
cd android
.\gradlew assembleRelease
```

Release APK location: `android\app\build\outputs\apk\release\app-release-unsigned.apk`

---

## 🎨 Customization

### Change App Icon
Replace icon files in: `android\app\src\main\res\mipmap-*\ic_launcher.png`

### Change App Name
Edit: `android\app\src\main\res\values\strings.xml`

### Change Package Name
Edit: `capacitor.config.json` → `appId`

### Rebuild After Changes
```powershell
npx cap sync
cd android
.\gradlew assembleDebug
```

---

## ✅ Success!

Your Smart Kitchen AI app is now packaged as an Android APK and ready to install on any Android device (API 22+, Android 5.0 and above).

For questions or issues, check the Capacitor documentation: https://capacitorjs.com/docs
