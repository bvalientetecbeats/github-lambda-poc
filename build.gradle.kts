import org.jetbrains.kotlin.gradle.tasks.KotlinCompile
import org.jlleitschuh.gradle.ktlint.KtlintExtension

plugins {
    val gradleVersionsPluginVersion: String by System.getProperties()
    val kotlinVersion: String by System.getProperties()
    val ktlintGradleVersion: String by System.getProperties()

    kotlin("jvm") version kotlinVersion
    kotlin("plugin.serialization") version kotlinVersion
    id("org.jlleitschuh.gradle.ktlint") version ktlintGradleVersion
    id("com.github.ben-manes.versions") version gradleVersionsPluginVersion
}

val awsVersion: String by project
val bbdbKotlinVersion: String by project
val kotlinUtilsVersion: String by project
val ktorVersion: String by project
val log4jVersion: String by project
val slf4jVersion: String by project

repositories {
    mavenCentral()
    levelRepo("big-bang-db-kotlin")
    levelRepo("kotlin-utils")
}

dependencies {
    implementation("com.levelgoals", "big-bang-db-kotlin", bbdbKotlinVersion)
    implementation("com.levelgoals", "kotlin-utils", kotlinUtilsVersion)
    implementation("io.ktor", "ktor-client-auth", ktorVersion)
    implementation("io.ktor", "ktor-client-content-negotiation", ktorVersion)
    implementation("io.ktor", "ktor-client-core", ktorVersion)
    runtimeOnly("io.ktor", "ktor-client-java", ktorVersion)
    implementation("io.ktor", "ktor-serialization-kotlinx-json", ktorVersion)
    runtimeOnly("org.apache.logging.log4j", "log4j-slf4j-impl", log4jVersion)
    implementation("org.slf4j", "slf4j-api", slf4jVersion)
    implementation("software.amazon.awssdk", "dynamodb-enhanced", awsVersion)
    implementation("software.amazon.awssdk", "ssm", awsVersion)
}

kotlin.sourceSets.main {
    kotlin.srcDirs("src")
}

sourceSets.main {
    resources.srcDirs("resources")
}

sourceSets.test {
    resources.srcDirs("test/resources")
}

tasks.withType<KotlinCompile> {
    kotlinOptions.jvmTarget = JavaVersion.VERSION_11.toString()
}

tasks.compileKotlin {
    dependsOn("ktlintFormat")
}

configure<KtlintExtension> {
    outputToConsole.set(true)
    disabledRules.set(
        setOf(
            "filename"
        )
    )
}

fun RepositoryHandler.levelRepo(name: String) = maven {
    url = uri("https://maven.pkg.github.com/levelgoals/$name")
    credentials {
        username = System.getenv("GITHUB_USERNAME")
        password = System.getenv("GITHUB_TOKEN")
    }
}
