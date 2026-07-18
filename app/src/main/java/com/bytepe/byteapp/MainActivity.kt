package com.bytepe.byteapp

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.google.android.material.button.MaterialButton
import com.google.android.material.textview.MaterialTextView
import kotlin.math.roundToInt

class MainActivity : AppCompatActivity() {
    private lateinit var titleView: MaterialTextView
    private lateinit var startButton: MaterialButton
    private lateinit var terrainState: MaterialTextView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        titleView = findViewById(R.id.titleText)
        startButton = findViewById(R.id.startButton)
        terrainState = findViewById(R.id.terrainState)

        titleView.text = "Byte Mobile"
        startButton.setOnClickListener {
            val generated = TerrainGenerator.generateWorld(8, 8)
            terrainState.text = "Terrain ready: ${generated.size} chunks, ${generated.sumOf { it.height }.roundToInt()} height seed"
        }
    }
}
