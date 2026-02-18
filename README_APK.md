# 📱 Smart Kitchen AI - Android APK Build

## Quick Start

This project includes everything needed to convert the Smart Kitchen AI web app into an Android APK.

### 🚀 Automated Build (Recommended)

1. **Install Prerequisites** (one-time setup):
   - [Node.js v18+](https://nodejs.org/) 
   - [Java JDK 17](https://adoptium.net/)
   - [Android Studio](https://developer.android.com/studio)

2. **Run the build script**:
   ```powershell
   .\build-apk.ps1
   ```

The script will:
- ✅ Check all prerequisites
- ✅ Install dependencies
- ✅ Configure Capacitor
- ✅ Build the APK automatically

### 📖 Detailed Instructions

See [INSTALLATION_GUIDE.md](INSTALLATION_GUIDE.md) for:
- Step-by-step prerequisite installation
- Manual build instructions
- Troubleshooting guide
- Customization options

### 📂 Project Files

- `package.json` - npm dependencies and scripts
- `capacitor.config.json` - Capacitor configuration
- `build-apk.ps1` - Automated build script
- `INSTALLATION_GUIDE.md` - Complete setup guide
- `android/` - Android Studio project (generated)

### 🎯 Output

After successful build, find your APK at:
```
android\app\build\outputs\apk\debug\app-debug.apk
```

### 💡 Quick Commands

```powershell
# Install dependencies
npm install

# Initialize everything
npm run setup

# Sync files to Android
npx cap sync

# Open in Android Studio
npx cap open android

# Build APK via Gradle
cd android
.\gradlew assembleDebug
```

### 🆘 Need Help?

1. Read `INSTALLATION_GUIDE.md` for detailed instructions
2. Check the troubleshooting section
3. Visit [Capacitor Docs](https://capacitorjs.com/docs)

---

**Version:** 10.5  
**Platform:** Android (API 22+)  
**Framework:** Capacitor 5
