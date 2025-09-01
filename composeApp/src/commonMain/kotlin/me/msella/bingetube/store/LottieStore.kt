package me.msella.bingetube.store

import androidx.compose.foundation.Image
import androidx.compose.runtime.Composable
import bingetube.composeapp.generated.resources.Res
import io.github.alexzhirkevich.compottie.Compottie
import io.github.alexzhirkevich.compottie.LottieComposition
import io.github.alexzhirkevich.compottie.LottieCompositionSpec
import io.github.alexzhirkevich.compottie.rememberLottiePainter
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

object LottieStore {

    // Enum to identify animations
    enum class Anim(val path: String) {
        ApiKey("files/lottie/api-key.json"),
        LoadingAirplane("files/lottie/loading-airplane.json"),
    }

    private val cache = mutableMapOf<Anim, LottieComposition>()

    suspend fun preload() {
        withContext(Dispatchers.Default) {
            for (anim in Anim.entries) {
                val json = Res.readBytes(anim.path).decodeToString()
                val composition = LottieCompositionSpec.JsonString(json).load()
                cache[anim] = composition
            }
        }
    }

    fun get(anim: Anim): LottieComposition =
        requireNotNull(cache[anim]) { "Animation ${anim.name} not loaded. Did you call preload()?" }


    @Composable
    fun Image(anim: Anim) {
        Image(
            painter = rememberLottiePainter(
                composition = get(anim),
                iterations = Compottie.IterateForever
            ),
            contentDescription = "Lottie animation"
        )
    }
}