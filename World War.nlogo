extensions [ gis ]
globals [ countries-dataset time monitor vector day loop_count start_index array_count org_monitor ]
patches-own [ name pop growth death org_soldier]

to setup
  clear-all
  gis:load-coordinate-system ("Countries.prj")
  set countries-dataset gis:load-dataset "Countries.shp"
  set vector gis:property-names countries-dataset
  gis:apply-coverage countries-dataset "NAME_LONG" name
  gis:apply-coverage countries-dataset "POP" pop
  gis:apply-coverage countries-dataset "POP_GROW" growth
  fix
  set time 365
  set-growth
  display-countries
  show-pop
  monitor-pop
  if (War = "World War 1")[
    set day [ 0 2 4 10 18 21 31 32 80 92 95 108 124 131 143 155 172 192 223 245 256 266 269 289 328 332 335 352 371 372 386 411 421 424 440 444 467 490 502 517 546 547 551 554 562 593 608 609 618 676
      692 736 749 769 772 811 812 837 858 912 930 943 957 970 988 1016 1070 1088 1129 1155 1162 1163 1175 1182 1303 1320 1370 1371 1375 1389 1392 1408 1418 1419 1422 1447 1462 1478 1484 1485 1492 1493
      1504 1520 1521 ]
    gis:apply-coverage countries-dataset "WW1_SOLDIE" org_soldier
  ]
  if (War = "World War 2")[
    set day [ 0 165 170 174 175 176 184 185 199 299 258 375 419 420 451 465 473 480 590 633 727 750 781 794 841 876 891 905 907 931 997 998 1027 1043 1059 1078 1154 115 1165 1187 1188  1214 12451 1252
      1267 1323 1331 1335 1349 1373 1409 1441 1489 1511 1566 1570 1571 1631 1686 1702 1704 1762 1767 1776 1778 1812 1844 1856 1892 1901 1962 1993 1995 1997 2025 2030 2084 2097 2108 2133 2143 2149 2164
      2190 2198 2205 2320 ]
     gis:apply-coverage countries-dataset "WW2_SOLDIE" org_soldier
  ]
  index
  set loop_count 0
  set array_count 0
   ask patches with [name = Country][
      set org_monitor round(pop)
  ]
end

to fix
  ask patches[
    if (name = "Belize")[
      set pop 347369
      set growth 1.87
    ]
    if (name = "Benin")[
      set pop 10448647
      set growth 2.78
    ]
    if (name = "Croatia")[
      set pop 4464844
      set growth -0.13
    ]
    if (name = "Denmark")[
      set pop 5581503
      set growth 0.22
    ]
    if (name = "Equatorial Guinea")[
      set pop 740743
      set growth 2.51
    ]
    if (name = "Guatemala")[
      set pop 14918999
      set growth 1.81
    ]
    if (name = "Guyana")[
      set pop 735222
      set growth 0.02
    ]
    if (name = "Haiti")[
      set pop 10110019
      set growth 1.17
    ]
    if (name = "Iran")[
      set pop 81824270
      set growth 1.2
    ]
    if (name = "Israel")[
      set pop 8049314
      set growth 1.56
    ]
    if (name = "Jamaica")[
      set pop 2950210
      set growth 0.68
    ]
    if (name = "Qatar")[
      set pop 2194817
      set growth 3.07
    ]
    if (name = "Senegal")[
      set pop 13975834
      set growth 2.45
    ]
    if (name = "Sierra Leone")[
      set pop 5879098
      set growth 2.35
    ]
    if (name = "Solomon Islands")[
      set pop 622469
      set growth 2.02
    ]
    if (name = "Somaliland")[
      set pop 3500000
      set growth 3.1
    ]
    if (name = "Sudan")[
       set pop 36108853
      set growth 1.72
    ]
    if (name = "Timor-Leste")[
      set pop 1231116
      set growth 2.42
    ]
    if (name = "Trinidad and Tobago")[
      set pop 1222363
      set growth -0.13
    ]
  ]
end

to display-countries
  let len 0
  gis:set-drawing-color white
  gis:draw countries-dataset .5
end

to set-growth
  ask patches[
    set growth growth * .01
    set growth growth / time
  ]
end

to show-pop
  ask patches [
    set pcolor sky
    if (pop <= 0)[
      set pcolor sky
    ]
    if (pop > 0 and pop < 10000)[
      set pcolor 119
    ]
    if (pop >= 10000 and pop < 100000)[
      set pcolor 129
    ]
    if (pop >= 100000 and pop < 1000000)[
      set pcolor 118
    ]
    if (pop >= 1000000 and pop < 2000000)[
      set pcolor 128
    ]
    if (pop >= 2000000 and pop < 5000000)[
      set pcolor 117
    ]
    if (pop >= 5000000 and pop < 7000000)[
      set pcolor 127
    ]
    if (pop >= 7000000 and pop < 10000000)[
      set pcolor 116
    ]
    if (pop >= 10000000 and pop < 20000000)[
      set pcolor 126
    ]
    if (pop >= 20000000 and pop < 80000000)[
      set pcolor 115
    ]
    if (pop >= 80000000 and pop < 100000000)[
      set pcolor 125
    ]
    if (pop >= 100000000 and pop < 500000000)[
      set pcolor 113
    ]
    if (pop >= 500000000 and pop < 1000000000)[
      set pcolor 123
    ]
    if (pop >= 1000000000 and pop < 1500000000)[
      set pcolor 112
    ]
    if (pop > 1500000000)[
      set pcolor black
    ]
]
end

to monitor-pop
  ask patches with [name = Country][
      set monitor round(pop)
  ]
end

to index
  let c 0
  if (War = "World War 1")[
    while [c < length vector][
      if item c vector = "F08051914"[
        set start_index c
        stop
      ]
      set c c + 1
    ]
  ]
  if (War = "World War 2")[
    while [c < length vector][
      if item c vector = "F03171939"[
        set start_index c
        stop
      ]
      set c c + 1
    ]
  ]
end

to go
  grow
  if (loop_count > start and loop_count < item (length day - 1) day)[
    kill
  ]
  show-pop
  monitor-pop
  set loop_count loop_count + 1
end

to grow
  ask patches [
    let new round(pop * growth)
    set pop pop + new
  ]
end

to kill
  if (loop_count < item (length day - 1) day + start)[
    if loop_count - start - 1 = item array_count day[
      gis:apply-coverage countries-dataset (item (start_index + array_count) vector) death
       ask patches [
         if (efficiency != 0)[
           if (org_soldier != 0)[
             let new_death death + round(death * (soldiers * .01 * pop) / org_soldier)
             set new_death new_death + round(new_death * efficiency * .01)
             if (pop - new_death) <= 0[
              set pop 0
             ]
             if (pop - new_death) > 0[
               set pop pop - new_death
             ]
           ]
           if (org_soldier = 0)[
             let new_death death + round(death * (soldiers * .01 * pop) / 1000 * efficiency * .01)
             if (pop - new_death) <= 0[
               set pop 0
             ]
             if (pop - new_death) > 0[
               set pop pop - new_death
             ]
           ]
         ]
         if (efficiency = 0)[
           if (pop - death > 0 and death > 0)[
             set pop pop - death
           ]
           if  (pop - death <= 0)[
             set pop 0
           ]
         ]
       ]
       set array_count array_count + 1
    ]
  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
389
10
1378
514
73
35
6.662
1
8
1
1
1
0
1
1
1
-73
73
-35
35
0
0
1
ticks
30.0

BUTTON
9
10
203
43
NIL
setup\n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

TEXTBOX
109
46
259
64
NIL
11
0.0
1

PLOT
213
31
380
309
-
NIL
NIL
0.0
10.0
0.0
10.0
false
true
"" ""
PENS
"0" 1.0 0 -13791810 true "" ""
"< 10,000" 1.0 0 -1712915 true "" ""
"< 100,000" 1.0 0 -1191199 true "" ""
"< 1,000,000" 1.0 0 -3425830 true "" ""
"< 2,000,000" 1.0 0 -2382653 true "" ""
"< 5,000,000" 1.0 0 -5204280 true "" ""
"< 7,000,000" 1.0 0 -3508570 true "" ""
"< 10,000,000" 1.0 0 -6917194 true "" ""
"< 20,000,000" 1.0 0 -4699768 true "" ""
"< 80,000,000" 1.0 0 -8630108 true "" ""
"< 100,000,000" 1.0 0 -5825686 true "" ""
"< 500,000,000" 1.0 0 -11783835 true "" ""
"< 1,000,000,000" 1.0 0 -10022847 true "" ""
"< 1,500,000,000" 1.0 0 -13360827 true "" ""
"> 1,500,000,000" 1.0 0 -16448764 true "" ""

TEXTBOX
217
10
367
28
Population Key
12
0.0
1

BUTTON
10
52
205
85
go
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
9
93
206
126
start
start
0
100
12
1
1
NIL
HORIZONTAL

CHOOSER
10
133
206
178
War
War
"World War 1" "World War 2"
1

MONITOR
212
368
383
413
Days
loop_count
0
1
11

INPUTBOX
8
207
204
267
soldiers
10
1
0
Number

INPUTBOX
10
295
208
355
efficiency
50
1
0
Number

TEXTBOX
11
186
161
204
Amount of Soldiers (%)
11
0.0
1

TEXTBOX
8
277
158
295
Weapon Efficiency (%)
11
0.0
1

CHOOSER
9
367
208
412
Country
Country
"Afghanistan" "Albania" "Algeria" "Angola" "Antarctica" "Argentina" "Australia" "Austria" "Azerbaijan" "Bahamas" "Bangladesh" "Belgium" "Belize" "Benin" "Bolivia" "Bosnia and Herzegovina" "Botswana" "Brazil" "Bulgaria" "Burkina Faso" "C?te d'Ivoire" "Cambodia" "Cameroon" "Canada" "Central African Republic" "Chad" "Chile" "China" "Colombia" "Costa Rica" "Croatia" "Cuba" "Czech Republic" "Dem. Rep. Korea" "Democratic Republic of the Congo" "Denmark" "Dominican Republic" "Ecuador" "Egypt" "Equatorial Guinea" "Eritrea" "Estonia" "Ethiopia" "Falkland Islands" "Fiji" "Finland" "France" "Gabon" "Georgia" "Germany" "Ghana" "Greece" "Greenland" "Guatemala" "Guinea" "Guinea-Bissau" "Guyana" "Haiti" "Honduras" "Hungary" "Iceland" "India" "Indonesia" "Iran" "Iraq" "Ireland" "Israel" "Italy" "Jamaica" "Japan" "Jordan" "Kazakhstan" "Kenya" "Kyrgyzstan" "Lao PDR" "Latvia" "Liberia" "Libya" "Lithuania" "Madagascar" "Malawi" "Malaysia" "Mali" "Marshall Islands" "Mexico" "Mongolia" "Morocco" "Mozambique" "Myanmar" "Namibia" "Nepal" "Netherlands" "New Caledonia" "New Zealand" "Nicaragua" "Niger" "Nigeria" "Norway" "Oman" "Pakistan" "Panama" "Papua New Guinea" "Paraguay" "Peru" "Philippines" "Poland" "Portugal" "Puerto Rico" "Qatar" "Republic of Congo" "Republic of Korea" "Romania" "Russian Federation" "Saudi Arabia" "Senegal" "Serbia" "Sierra Leone" "Solomon Islands" "Somalia" "Somaliland" "South Africa" "South Sudan" "Spain" "Sri Lanka" "Sudan" "Suriname" "Sweden" "Syria" "Taiwan" "Tajikistan" "Tanzania" "Thailand" "Timor-Leste" "Trinidad and Tobago" "Tunisia" "Turkey" "Turkmenistan" "Uganda" "Ukraine" "United Arab Emirates" "United Kingdom" "United States" "Uruguay" "Uzbekistan" "Venezuela" "Vietnam" "Yemen" "Zambia" "Zimbabwe"
49

MONITOR
9
421
209
466
Population
monitor
17
1
11

MONITOR
217
421
381
466
Difference
org_monitor - monitor
17
1
11

@#$#@#$#@
Setup
- Sets all of the data for each variable
- Initializes all global variables
- Displays the basic map with the current population

Go
- Starts the simulation

Start
- User can set the day of which the war starts

War
- User can choose which war data will be used in the simulation

Amount of Soldiers (%)
- User can define the percentage of the people in each country will become soldiers
	- This will be uniform along all the countries

Weapon Efficiency (%)
- User can define the percentage of which the weapon efficiency has increased since the war
	- This will be uniform along all the countries

Country
- User can select which country to monitor

Population
- The population of the country that the user selected to monitor

Days
- This displays the day that the model is on

Population Key
-  A key that explains the different colors in the model
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270

@#$#@#$#@
NetLogo 5.3
@#$#@#$#@
setup
display-cities
display-countries
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

@#$#@#$#@
0
@#$#@#$#@
