package me.msella.bingetube

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform