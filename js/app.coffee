---
---

'use strict'

convertHex = (hex, opacity = 1) ->
    hex = hex.replace('#', '')
    r = parseInt(hex.substring(0,2), 16)
    g = parseInt(hex.substring(2,4), 16)
    b = parseInt(hex.substring(4,6), 16)
    a = opacity / 100

    result = "rgba(#{r},#{g},#{b},#{a})"


$.getJSON '/data/css-color-names.json', (data) ->

    colors = data

    $appContainer = $ '#app'

    $swatchesContainer = $ '<div class="swatches"></div>'

    $.each colors, (colorName, colorHex) ->

        $swatchesContainer.append "<div class='swatch' style='background-color: #{colorHex}'>#{colorName}</div>"

    $appContainer.append $swatchesContainer



