package me.msella.bingetube

import androidx.compose.runtime.mutableStateOf
import me.msella.bingetube.store.LottieStore

object AppCache {

    var isReadyForSplashScreen = mutableStateOf(false)

    suspend fun prepareForSplashScreen() {
        LottieStore.preload(LottieStore.Anim.BingePanda)
    }

    suspend fun prepareForAll() {
        LottieStore.preload()
    }

}