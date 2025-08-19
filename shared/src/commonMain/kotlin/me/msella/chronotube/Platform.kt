package me.msella.chronotube

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform