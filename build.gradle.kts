import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
    kotlin("jvm") version "1.6.20"
    application
}

val awsVersion: String by project
val awsLambdaJavaCoreVersion: String by project
val awsLambdaJavaEventsVersion: String by project
//val bigBangDbKotlinVersion: String by project
//val kotlinSerializationVersion: String by project
//val kotlinUtilsVersion: String by project

group = "org.example"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

dependencies {
    testImplementation(kotlin("test"))
    implementation("com.amazonaws", "aws-lambda-java-core", awsLambdaJavaCoreVersion)
    implementation("com.amazonaws", "aws-lambda-java-events", awsLambdaJavaEventsVersion)
    implementation(platform("software.amazon.awssdk:bom:$awsVersion"))
    implementation("software.amazon.awssdk", "ssm")
    implementation("org.junit.jupiter:junit-jupiter:5.8.2")
    testImplementation("io.mockk:mockk:1.12.3")
    implementation(kotlin("stdlib-jdk8"))
}

tasks.test {
    useJUnitPlatform()
}

tasks.withType<KotlinCompile> {
    kotlinOptions.jvmTarget = "1.8"
}

application {
    mainClass.set("MainKt")
}


kotlin.sourceSets.main {
    kotlin.srcDirs("src/main")
}

sourceSets.main {
    resources.srcDirs("resources")
}

sourceSets.test {
    resources.srcDirs("src/test")
}



/*

import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
    kotlin("jvm") version "1.6.20"
    application
}

group = "me.oren"
version = "1.0-SNAPSHOT"

val awsVersion: String by project
val awsLambdaJavaCoreVersion: String by project
val awsLambdaJavaEventsVersion: String by project
val bigBangDbKotlinVersion: String by project
val kotlinSerializationVersion: String by project
val kotlinUtilsVersion: String by project

repositories {
    mavenCentral()
}

dependencies {
    implementation("com.amazonaws", "aws-lambda-java-core", awsLambdaJavaCoreVersion)
    implementation("com.amazonaws", "aws-lambda-java-events", awsLambdaJavaEventsVersion)
    implementation(platform("software.amazon.awssdk:bom:$awsVersion"))
    implementation("software.amazon.awssdk", "ssm")
    implementation("org.junit.jupiter:junit-jupiter:5.8.2")
    testImplementation(kotlin(""))
    testImplementation("io.mockk:mockk:1.12.3")
    implementation(kotlin("stdlib-jdk8"))
}


tasks.withType<KotlinCompile> {
    kotlinOptions.jvmTarget = "1.8"
}

application {
    mainClass.set("MainKt")
}
val compileKotlin: KotlinCompile by tasks
compileKotlin.kotlinOptions {
    jvmTarget = "1.8"
}
//val compileTestKotlin: KotlinCompile by tasks
//compileTestKotlin.kotlinOptions {
//    jvmTarget = "1.8"
//}


kotlin.sourceSets.main {
    kotlin.srcDirs("src")
}

sourceSets.main {
    resources.srcDirs("resources")
}

sourceSets.test {
    resources.srcDirs("test")
}

dependencies {
    testImplementation(kotlin("test"))
}

tasks.test {
    useJUnitPlatform()
}

//tasks.compileKotlin {
//    dependsOn("ktlintFormat")
//}

//configure<KtlintExtension> {
//    outputToConsole.set(true)
//    disabledRules.set(
//        setOf(
//            "filename"
//        )
//    )
//}

//fun RepositoryHandler.levelRepo(name: String) = maven {
//    url = uri("https://maven.pkg.github.com/levelgoals/$name")
//    credentials {
//        username = System.getenv("GITHUB_USERNAME")
//        password = System.getenv("GITHUB_TOKEN")
//    }
//}

 */