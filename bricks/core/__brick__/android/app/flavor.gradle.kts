import java.util.Properties
import java.io.FileInputStream

import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)
val keystoreProperties = Properties().apply {
    val keystoreFile = rootProject.file("key.properties")
    if (keystoreFile.exists()) {
        load(FileInputStream(keystoreFile))
    }
}

android.apply {
    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = keystoreProperties["storeFile"]?.let { file(it as String) }
            storePassword = keystoreProperties["storePassword"] as String
        }
    }


    flavorDimensions("flavor-type")

    productFlavors {
        create("production") {
            dimension = "flavor-type"
            resValue(type = "string", name = "app_name", value = "Sample")
        }
        create("development") {
            dimension = "flavor-type"
            resValue(type = "string", name = "app_name", value = "[DEV] Sample")
        }
    }
}