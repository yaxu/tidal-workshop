
# Introduction

TidalCycles is a language for the exploration of pattern.

What is a pattern? How can we explore them as code? In this workshop
we will explore some advanced topics, to try to understand what that
means. I'm not sure myself, but lets try.

I have been making a new version of TidalCycles for these workshops,
so we can try something new. It's version 1.0-pre, which is not
officially released, but works and has some exciting new features. You
can install it with this command in a terminal window:

```
cabal install http://slab.org/tokyo/tidal-1.0.0-pre.tar.gz
```


If you want to uninstall it again you can run this command:

```
ghc-pkg unregister tidal-1.0.0
```

... then your old version will start running again (once you restart your text editor).

# Workshop topics

We have spare time. Please ask questions throughout if you would like me to cover something extra.

* Interaction
* Structure
* Tempo patterns
* External control

* Extra topics, if we have time
  * Composing functions

-- structure comes from the left
d1 $ sound "arpy" # vowel "a e"

d1 $ vowel "a e" # sound "arpy"

d1 $ sound "drum" # n "0 3 4 1"

d1 $ n "0 3 4 1" # sound "drum"

d1 $ n "0 3 4 1" # sound "drum"

d1 $ fast 2 $ n "0 1 2 3" # sound "drum"

d1 $ fast "2 4" $ sound "ht mt lt mt"

-- * - 'speed up' a step
d1 $ sound "bd bd bd*2 bd"

d1 $ sound "bd bd [bd sn:1]*0.5 bd"

d1 $ sound "bd bd [bd sn:1]*1.5 bd"

-- / - 'slow down' a step

d1 $ sound "bd sn:2/2"

-- <> - pick one per cycle
d1 $ sound "bd sn <arpy arpy:2> bd"

d1 $ sound "bd sn [arpy arpy:2]/2 bd"

-- ? - randomly 'drop' a step

d1 $ sound "bd sn mt? lt"

-- up a level - higher order functions
cps 1.05

d1 $ every 3 rev $ slow 2 $ n "0 1 2 3" # sound "alphabet"

d1 $ every 3 (# speed "-1") (n "0 3 1 4" # sound "alphabet")

d1 $ sound "cp*4"
  # vowel "<e i o u>"

d1 $ sound "bd(3,8) sn:2" # hpf "300 5000" # hpq 0.2

d1 $ jux (0.125 <~) $ every 4 (fast 2) $
   sound "bd cp arpy cp:2"
   # hpf (slow 2 $ scale 100 5000 saw)
   # hpq 0.2

d1 $ sound "bd*8" # pan rand

d1 $ sound "bd*8" # pan rand # speed rand

d1 $ sound "bd*8" # pan rand # speed (fast 2 rand)

d1 $ n (irand 8) # sound "arpy"

d1 $ n (struct "x(3,8)" $ irand 8) # sound "arpy"


d1 $ jux rev $ every 2 (slow 2)
   $ fast 2 $ n (struct "x(3,8)" $ irand 32)
   # sound "amencutup"

d1 $ n ("0*2 4*2" + fastcat[0, irand 32])
    # sound "amencutup"

-- play in turn (fastcat does the same but squeezes in one cycle)
d1 $ cat [sound "bd sn:2",
          sound "arpy arpy:3" # crush 3,
          sound "bd(3,8)"
         ]

-- play in random order
d1 $ randcat [sound "bd sn:2",
              sound "arpy arpy:3" # crush 3,
              sound "bd(3,8)"
             ]

-- play on top of each other.
-- note the effect on the end applies to all
d1 $ stack [sound "bd sn:2",
            sound "arpy arpy:3" # crush 3,
            sound "bd(3,8)"
           ] # speed "<2 3>"

hush

hush

d1 $ degrade $ sound "bd*8"

d1 $ sometimes (# crush 3) $ sound "bd*8"

d1 $ someCycles (# crush 3) $ sound "bd*8"

hush

d1 $ sound "bd cp? ~ bd"



d1 $ sound "bd(<5 3>,8)"

(4,7,1)

[.x.x.xx]

    (2,5) : A thirteenth century Persian rhythm called Khafif-e-ramal.
    (3,4) : The archetypal pattern of the Cumbia from Colombia, as well as a Calypso rhythm from Trinidad.
    (3,5,2) : Another thirteenth century Persian rhythm by the name of Khafif-e-ramal, as well as a Rumanian folk-dance rhythm.
    (3,7) : A Ruchenitza rhythm used in a Bulgarian folk-dance.
    (3,8) : The Cuban tresillo pattern.
    (4,7) : Another Ruchenitza Bulgarian folk-dance rhythm.
    (4,9) : The Aksak rhythm of Turkey.
    (4,11) : The metric pattern used by Frank Zappa in his piece titled Outside Now.
    (5,6) : Yields the York-Samai pattern, a popular Arab rhythm.
    (5,7) : The Nawakhat pattern, another popular Arab rhythm.
    (5,8) : The Cuban cinquillo pattern.
    (5,9) : A popular Arab rhythm called Agsag-Samai.
    (5,11) : The metric pattern used by Moussorgsky in Pictures at an Exhibition.
    (5,12) : The Venda clapping pattern of a South African children’s song.
    (5,16) : The Bossa-Nova rhythm necklace of Brazil.
    (7,8) : A typical rhythm played on the Bendir (frame drum).
    (7,12) : A common West African bell pattern.
    (7,16,14) : A Samba rhythm necklace from Brazil.
    (9,16) : A rhythm necklace used in the Central African Republic.
    (11,24,14) : A rhythm necklace of the Aka Pygmies of Central Africa.
    (13,24,5) : Another rhythm necklace of the Aka Pygmies of the upper Sangha.

hush

d1 $ every 3 (fast 4) $ sound "bd sn:2"

d1 $ jux (# speed "-1") $ sound "bd ~ cp sn:2"



0 1
2 3

3 2 0 1
1 0 3 2

d1 $ sound "bd sn:1/3"


d1 $ rev $ loopAt 4 $ chop 16 $ sound "breaks152"

hush

http://slab.org:8080/index16.html


d1 $ up ("0 7 12" + "<7 12>") # sound "arpy"


-- softsynths + note names
d2 $ n "c5 d*2 [~ e] gs4"
   # sound "supermandolin"

d2 $ n ("c5 d*2 [~ e] gs4" + "0 7")
     # sound "supermandolin"
     # crush 4

-- legato to make the decay longer by a factor
d3 $ n "c6 ~ g6 ~"
   # sound "supermandolin"
   # legato 4

-- sustain to give decay in seconds
d3 $ n "c6 ~ g6 ~"
  # sound "supermandolin"
  # sustain 0.4

d1 $ off 0.125 (# crush 2) $
   sound "bd(3,8) cp"

d3 $ off 0.25 (# (s "superpiano" # gain 0.6))
     $ jux rev $ slow 2
     $ n (off 0.25 (+12) $ off 0.125 (+7)
     $ slow 2 "c5(3,8) e3*2 g5(3,8) a4(3,8)")
     # sound "supermandolin"
     # sustain 0.6

http://is.gd/limerick

d1 $ n "c(3,8) e(3,8)" # sound "supermandolin"

d1 $ off "<0.25 0.125>" (# crush 3)
   $ n "0 3 [~ 3] 4" # sound "feel"

d1 $ n ("c(3,8)" + chord "major minor")
  # sound "supermandolin"
  # legato 4

-- chords
d1 $ n ("c e" + chord "minor")
   # s "supermandolin"

d1 $ n (off 0.25 (+ chord "major")
        "<c(3,8) e f g>" )
   # s "supermandolin"
   # legato 4
   # lpf 3000 # lpq 0.2

d1 $ off "<0 0.25 0.5>"
     (# crush 2) $ sound "odx(3,8)"

cps 1.1

d1 $ jux rev $ loopAt 16 $
  chop 256 $ sound "bev"

d2 $ every 3 rev $
   loopAt 2 $ chop 4 $ sound "breaks125"

d1 $ jux rev $ chop 16 $ sound "cp(3,8)"

d2 $ (chop 128 $ sound "bd(3,8) sn:2")
  # nudge (slow 8 sine)

t1 (mortal 16 32) $ sound "bd(3,8) sn:1"

t2 (mortal 16 32) $ up "0 [7 12]" # sound "jungbass"

t1 (anticipate)
  $ n "0 2*2 [3 4] 3" # sound "drum"

t1 (histpan 4) $ sound "off bd"

d1 $ sound "bd*4"
  # orbit 1
  # delay 0.9
  # delaytime (slow 4 $ scale 0.01 0.03 sine)
  # delayfeedback 0.9

d1 silence

d2 $ sound "drum" # gain 1.1

d1 $ jux rev $ n "c6 [c8 c7] g8 e6"
  # sound "rash"
  # lpf 3000 # lpq 0.1

d2 $ iter 4 $ jux rev $ loopAt 4 $ chop 16
  $ sound "repetition"
  # n (irand 5)

d3 $ chunk 4 (hurry 2) $ iter 4 $ loopAt 2 $ chop 8
   $ sound "arc"
   # gain 1.2

d1 $ chunk 4 (slow 2)
   $ loopAt 2 $ chop 8 $ sound "arc"

-- these are the same
d1 $ fast 4 $ sound "bd" # speed 4
d1 $ hurry 4 $ sound "bd"

d1 $ every 4 (hurry 4) $ sound "bd sn:2"

d1 $ jux rev $ chunk 4 (hurry 2)
   $ sound "bd sn:2"

-- find all the chord names in here:
https://github.com/tidalcycles/Tidal/blob/master/Sound/Tidal/Chords.hs

htotps://github.com/supercollider/sc3-plugins

http://slab.org/tmp/extra-samples.zip

-- download this (via the green download button)
https://github.com/yaxu/p5dirt

algosix stream:
https://docs.google.com/spreadsheets/d/1vtqxi98Z4JzO8Csm5omI_y0acJu4QA5E9GXaSduqgpU/edit#gid=0

stream with this!
https://obsproject.com/download

-- composition

d1 $ cat [n "[0 .. 3] 6" # sound "drum"
          # crush 3,
          sound "cp"
         ]

d1 $ seqP [(0, 2,
            n "[0 .. 3] 6" # sound "drum"
            # crush 3
           ),
           (1,3, sound "gabba(3,8)")
          ]

let melody = sound "arpy"
    drums = sound "drum drum:2"
in
d1 $ seqPLoop [(0, 2,
                n "[0 .. 3] 6" # sound "drum"
                # crush 3
               ),
               (1,3, drums),
               (2,4, melody),
               (4,6, drums)
              ]

d1 $ ur' 16 "[rise:fadeIn drums, break:fadeIn break:distort]"
   [("rise", n "0 .. 3" # sound "arpy"),
    ("drums", n "0 .. 7" # sound "drum" # speed 2),
    ("break", loopAt 2 $ chop 16 $ sound "arc")
   ]
   [("distort", (# shape 0.7)),
    ("fadeIn", (# gain saw))
   ]

d1 $ sound "bd*8"
   # gain (slow 8 $ rev saw)

t1 (xfade) $ sound "bd(3,8)"
t1 (xfadeIn 8) $ sound "bd(3,8)"

t1 (clutchIn 16) $ sound "bd(3,8) mt ht lt"

d1 $ speed ("[1 0.5 0.75, 2.25 3 6 0.5]")
   # n "c6 e6*3 f6 g6" # sound "rash"




d1 $ sound "bd*8"

hush

floor <$> getNow

cps (-1)

cps 1.1

d1 $ degrade $ off 0.125 (|*| speed 2) $ chunk 4 (hurry 2) $ (off 0.25 (|*| speed "<2 3>")
  $ n "0 .. 3" # sound "[micron]")
  # orbit 1


d2 $ degrade $ slow 2 $ chunk 4 (hurry 2) $ jux (rev . (|*| crush 4)) $ sound "osc1:1(3,8,<0 5 2>)"
  # legato (scale 0.5 1 $ slow 4 sine) |*| speed "[1,1.5 2]"



d1 $ sound "arc [~ arc]"
 # legato (slow 4 sine)

d1 silence

d3 $ jux (rev . (|+| n 2)) $ chop "<8 4>" $
  chunk 4 (hurry 0.5) $ n "0 2 3 1" # sound "speakspell"
  # hpf "<1004 2000>" # hpq 0.2

d1 $ speed "1 2 1 1.5" # sound "arpy"
  |+| speed (scale 1 2 $ slow 4 sine)



d4 silence

d4 $ sound "bd*8"



d2 $ never (off 0.25 (# s "pulse")) $
  n (off 0.125 (+12) $ off 0.25 (+ "<7 -12>") $
  slow 2 $ "c7(3,8) [~ g8*2]")
  # sound "rash"
  -- # orbit 2 # room 0.4 # size 0.9 |+| n "<0 7 2 5>"

-- never, almostNever, sometimes, often, almostAlways, always
d1 $ never (# speed 2) $ sound "bd sn"

d1 $ sound "wobble"

d2 $ sound "bd(3,8) odx"

hush

hush

