---
---

'use strict'

hexToRgb = (hex) ->
    hex = hex.replace('#', '')
    r = parseInt(hex.substring(0,2), 16)
    g = parseInt(hex.substring(2,4), 16)
    b = parseInt(hex.substring(4,6), 16)

    result = [r,g,b]


rgbToHsl = (rgb) ->

    [r,g,b] = rgb

    r /= 255
    g /= 255
    b /= 255

    max = Math.max(r, g, b)
    min = Math.min(r, g, b)

    h = undefined
    s = undefined
    l = (max + min) / 2

    if max == min
        h = s = 0
    else
        d = max - min
        s = if l > 0.5 then d / (2 - max - min) else d / (max + min)

    switch max
        when r
            h = (g - b) / d + (if g < b then 6 else 0)
        when g
            h = (b - r) / d + 2
        when b
            h = (r - g) / d + 4
            h /= 6

    return [
        h * 100 + 0.5 | 0
        (s * 100 + 0.5 | 0) + '%'
        (l * 100 + 0.5 | 0) + '%'
    ]

$.getJSON '/data/css-color-names.json', (data) ->

    colors = data

    $appContainer = $ '#app'

    $swatchesContainer = $ '<div class="swatches"></div>'

    index = 0

    $.each colors, (colorName, colorHex, i) ->

        index++

        hex = colorHex
        rgb = hexToRgb hex
        hsl = rgbToHsl rgb

        rgbFormat = "rgb(#{rgb.join(',')})"
        hslFormat = "hsl(#{hsl.join(',')})"

        $swatch = $ "<div class='swatch' style='background-color: #{colorHex};opacity: 1;-webkit-animation-duration: #{index * 100}s' data-id=#{colorName}>
                <ul class='swatch-values'>
                    <li class='swatch-value swatch-name'>#{colorName}</li>
                    <li class='swatch-value swatch-hex'>#{hex}</li>
                    <li class='swatch-value swatch-rgb'>#{rgbFormat}</li>
                    <li class='swatch-value swatch-hsl'>#{hslFormat}</li>
                </ul>
            </div>"

        $swatchesContainer.append $swatch

    $appContainer.append $swatchesContainer



