# Smart Kitchen AI - Automated APK Build Script
# This script automates the entire build process

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  Smart Kitchen AI - APK Build Script" -ForegroundColor Cyan
Write-Host "  Version 10.5" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Function to check if a command exists
function Test-Command {
    param($Command)
    try {
        if (Get-Command $Command -ErrorAction Stop) {
            return $true
        }
    } catch {
        return $false
    }
}

# Check Prerequisites
Write-Host "Step 1: Checking Prerequisites..." -ForegroundColor Yellow
Write-Host ""

$allPrerequisitesMet = $true

# Check Node.js
if (Test-Command "node") {
    $nodeVersion = node --version
    Write-Host "[✓] Node.js installed: $nodeVersion" -ForegroundColor Green
} else {
    Write-Host "[✗] Node.js NOT installed" -ForegroundColor Red
    Write-Host "    Download from: https://nodejs.org/" -ForegroundColor Yellow
    $allPrerequisitesMet = $false
}

# Check npm
if (Test-Command "npm") {
    $npmVersion = npm --version
    Write-Host "[✓] npm installed: v$npmVersion" -ForegroundColor Green
} else {
    Write-Host "[✗] npm NOT installed" -ForegroundColor Red
    $allPrerequisitesMet = $false
}

# Check Java
if (Test-Command "java") {
    $javaVersion = java -version 2>&1 | Select-String "version" | Select-Object -First 1
    Write-Host "[✓] Java installed: $javaVersion" -ForegroundColor Green
} else {
    Write-Host "[✗] Java NOT installed" -ForegroundColor Red
    Write-Host "    Download from: https://adoptium.net/" -ForegroundColor Yellow
    $allPrerequisitesMet = $false
}

# Check Android Home
if ($env:ANDROID_HOME) {
    Write-Host "[✓] ANDROID_HOME set: $env:ANDROID_HOME" -ForegroundColor Green
} else {
    Write-Host "[✗] ANDROID_HOME NOT set" -ForegroundColor Red
    Write-Host "    Please install Android Studio and set ANDROID_HOME" -ForegroundColor Yellow
    $allPrerequisitesMet = $false
}

Write-Host ""

if (-not $allPrerequisitesMet) {
    Write-Host "❌ Prerequisites not met. Please install missing tools." -ForegroundColor Red
    Write-Host "   📖 See INSTALLATION_GUIDE.md for detailed instructions." -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "✅ All prerequisites met!" -ForegroundColor Green
Write-Host ""

# Step 2: Install Dependencies
Write-Host "Step 2: Installing Dependencies..." -ForegroundColor Yellow
if (Test-Path "node_modules") {
    Write-Host "Dependencies already installed. Skipping..." -ForegroundColor Gray
} else {
    npm install
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Failed to install dependencies" -ForegroundColor Red
        exit 1
    }
}
Write-Host ""

# Step 3: Initialize Capacitor (if not already done)
Write-Host "Step 3: Initializing Capacitor..." -ForegroundColor Yellow
if (Test-Path "capacitor.config.json") {
    Write-Host "Capacitor already configured. Skipping..." -ForegroundColor Gray
} else {
    npx @capacitor/cli init "Smart Kitchen AI" "com.smartkitchen.ai" --web-dir="."
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Failed to initialize Capacitor" -ForegroundColor Red
        exit 1
    }
}
Write-Host ""

# Step 4: Add Android Platform (if not already done)
Write-Host "Step 4: Adding Android Platform..." -ForegroundColor Yellow
if (Test-Path "android") {
    Write-Host "Android platform already added. Skipping..." -ForegroundColor Gray
} else {
    npx cap add android
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Failed to add Android platform" -ForegroundColor Red
        exit 1
    }
}
Write-Host ""

# Step 5: Sync Files
Write-Host "Step 5: Syncing Web Files..." -ForegroundColor Yellow
npx cap sync
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Failed to sync files" -ForegroundColor Red
    exit 1
}
Write-Host ""

# Step 6: Build APK
Write-Host "Step 6: Building APK..." -ForegroundColor Yellow
Write-Host "This may take several minutes on first build..." -ForegroundColor Gray
Write-Host ""

Set-Location android
.\gradlew assembleDebug
$buildResult = $LASTEXITCODE
Set-Location ..

if ($buildResult -eq 0) {
    Write-Host ""
    Write-Host "================================================" -ForegroundColor Green
    Write-Host "  ✅ APK BUILD SUCCESSFUL!" -ForegroundColor Green
    Write-Host "================================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "📱 APK Location:" -ForegroundColor Cyan
    Write-Host "   android\app\build\outputs\apk\debug\app-debug.apk" -ForegroundColor White
    Write-Host ""
    Write-Host "📦 File Size:" -ForegroundColor Cyan
    $apkPath = "android\app\build\outputs\apk\debug\app-debug.apk"
    if (Test-Path $apkPath) {
        $size = (Get-Item $apkPath).Length / 1MB
        Write-Host "   $([math]::Round($size, 2)) MB" -ForegroundColor White
    }
    Write-Host ""
    Write-Host "🚀 Next Steps:" -ForegroundColor Cyan
    Write-Host "   1. Transfer APK to your Android device" -ForegroundColor White
    Write-Host "   2. Enable 'Install from Unknown Sources'" -ForegroundColor White
    Write-Host "   3. Install and enjoy!" -ForegroundColor White
    Write-Host ""
    Write-Host "   Or use: adb install android\app\build\outputs\apk\debug\app-debug.apk" -ForegroundColor Yellow
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "❌ APK BUILD FAILED" -ForegroundColor Red
    Write-Host ""
    Write-Host "Troubleshooting:" -ForegroundColor Yellow
    Write-Host "1. Try opening the project in Android Studio:" -ForegroundColor White
    Write-Host "   - Open Android Studio" -ForegroundColor Gray
    Write-Host "   - File → Open → Select 'android' folder" -ForegroundColor Gray
    Write-Host "   - Let Gradle sync complete" -ForegroundColor Gray
    Write-Host "   - Build → Build APK" -ForegroundColor Gray
    Write-Host ""
    Write-Host "2. Check INSTALLATION_GUIDE.md for more help" -ForegroundColor White
    Write-Host ""
}

Read-Host "Press Enter to exit"
