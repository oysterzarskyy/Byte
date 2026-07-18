package com.bytepe.byteapp

import kotlin.math.abs
import kotlin.math.floor
import kotlin.math.roundToInt

data class Chunk(val x: Int, val y: Int, val height: Int)

object TerrainGenerator {
    fun generateWorld(width: Int, height: Int): List<Chunk> {
        val chunks = mutableListOf<Chunk>()
        for (x in 0 until width) {
            for (y in 0 until height) {
                val noise = fbm(x.toDouble() * 0.34, y.toDouble() * 0.34)
                val terrainHeight = ((noise + 1.0) * 5.0).roundToInt().coerceIn(1, 12)
                chunks += Chunk(x, y, terrainHeight)
            }
        }
        return chunks
    }

    private fun fbm(x: Double, y: Double): Double {
        var value = 0.0
        var amplitude = 0.5
        var frequency = 1.0
        repeat(4) {
            value += amplitude * noise(x * frequency, y * frequency)
            amplitude *= 0.5
            frequency *= 2.0
        }
        return value
    }

    private fun noise(x: Double, y: Double): Double {
        val ix = floor(x).toInt()
        val iy = floor(y).toInt()
        val fx = x - ix
        val fy = y - iy

        val a = hash(ix, iy)
        val b = hash(ix + 1, iy)
        val c = hash(ix, iy + 1)
        val d = hash(ix + 1, iy + 1)

        val u = fx * fx * (3.0 - 2.0 * fx)
        val v = fy * fy * (3.0 - 2.0 * fy)

        val ab = a + (b - a) * u
        val cd = c + (d - c) * u
        return ab + (cd - ab) * v
    }

    private fun hash(x: Int, y: Int): Double {
        val s = (x * 374761393 + y * 668265263) xor (x * 0x9e3779b9)
        val n = s and 0x7fffffff
        return ((n % 1000) / 1000.0) * 2.0 - 1.0
    }
}
