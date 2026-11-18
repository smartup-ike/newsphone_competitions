import java.util.Properties

plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.akep.app14614"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_1_8.toString()
    }

    defaultConfig {
        // applicationId is set per flavor (see productFlavors below).
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion // Changed from flutter.minSdkVersion to 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    signingConfigs {
        create("release") {
            storeFile = file("$rootDir/release-key.jks")
            storePassword = "14614akep"
            keyAlias = "release-key-alias"
            keyPassword = "14614akep"
        }
        // 14800 has its own key. Keystore + passwords live in
        // android/keystores/ (not in git). Back them up safely.
        val app14800Props = rootProject.file("keystores/app14800.properties")
        if (app14800Props.exists()) {
            val p = Properties().apply { app14800Props.inputStream().use { load(it) } }
            create("app14800Release") {
                storeFile = rootProject.file(p.getProperty("storeFile"))
                storePassword = p.getProperty("storePassword")
                keyAlias = p.getProperty("keyAlias")
                keyPassword = p.getProperty("keyPassword")
            }
        }
    }

    // One flavor per app (number). Names must match lib/flavors/all_flavors.dart
    // and the iOS schemes. Firebase config: src/<flavor>/google-services.json.
    flavorDimensions += "app"
    productFlavors {
        create("app14614") {
            dimension = "app"
            applicationId = "com.akep.app14614"
            resValue("string", "app_name", "14614")
            signingConfig = signingConfigs.getByName("release")
        }
        create("app14800") {
            dimension = "app"
            applicationId = "com.akep.app14800"
            resValue("string", "app_name", "14800")
            signingConfig = signingConfigs.findByName("app14800Release")
        }
    }

    buildTypes {
        getByName("debug") {
            signingConfig = signingConfigs.getByName("debug")
        }
        getByName("release") {
            isMinifyEnabled = false
            isShrinkResources = false
            // Signing key is chosen per app in productFlavors.
        }
    }
}
dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    implementation(platform("com.google.firebase:firebase-bom:33.11.0"))
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-auth")
}

flutter {
    source = "../.."
}

// Apps without Firebase set up yet have no src/<flavor>/google-services.json.
// Skip the google-services step for them so they still build (they run
// without login/push/analytics until Firebase is added).
tasks.configureEach {
    val match = Regex("^process(.+?)(Debug|Profile|Release)GoogleServices$").find(name)
    if (match != null) {
        val flavor = match.groupValues[1].replaceFirstChar { it.lowercase() }
        if (!file("src/$flavor/google-services.json").exists()) {
            enabled = false
        }
    }
}
