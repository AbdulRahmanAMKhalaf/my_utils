allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Redirect Android build output to Flutter's root `build/` directory
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    // Each subproject (e.g., :app) gets its own folder under ../../build/
    project.layout.buildDirectory.set(newBuildDir.dir(project.name))
}

// Clean task that respects the custom build dir
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}