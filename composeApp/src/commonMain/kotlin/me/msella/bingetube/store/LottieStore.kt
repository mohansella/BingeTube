package me.msella.bingetube.store

import androidx.compose.foundation.Image
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.layout.ContentScale
import bingetube.composeapp.generated.resources.Res
import io.github.alexzhirkevich.compottie.*
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

object LottieStore {

    // Enum to identify animations
    enum class Anim(val path: String) {
        ShakingKeys("shaking-keys"),
        FlyingPaperPlane("flying-paper-plane"),
        BingePanda("binge-panda")
    }

    private val cache = mutableMapOf<Anim, LottieComposition>()

    suspend fun preload() {
        withContext(Dispatchers.Default) {
            for (anim in Anim.entries) {
                preload(anim)
            }
        }
    }

    suspend fun preload(anim: Anim) {
        if (cache.containsKey(anim)) {
            return
        }
        val bytes = Res.readBytes("files/lottie/${anim.path}.lottie")
        val composition = LottieCompositionSpec.DotLottie(bytes).load()
        cache[anim] = composition
    }

    fun get(anim: Anim): LottieComposition =
        requireNotNull(cache[anim]) { "Animation ${anim.name} not loaded. Did you call preload()?" }


    @Composable
    fun Image(
        anim: Anim,
        modifier: Modifier = Modifier,
        speed: Float = 1f,
        contentScale: ContentScale = ContentScale.Fit
    ) {
        Image(
            painter = rememberLottiePainter(
                composition = get(anim),
                iterations = Compottie.IterateForever,
                speed = speed,
            ),
            contentDescription = "Lottie animation",
            contentScale = contentScale,
            modifier = modifier
        )
    }
}