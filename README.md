# MusixMatch API Client

Project to gather useful information from MusixMatch API.

## Resources

* Songs
* Lyrics
* Artists
* Albums

## Elements

* Artists
  - artist_id
  - name
  - albums
  - songs

* Albums
  - album_id
  - name
  - year
  - artist_id

* Songs
  - song_id
  - name
  - year
  - artist_id
  - lyrics_id

* Lyrics
  - lyric_id
  - song_id
  - text
  - whether its a translation translation
  - language

## Entities

* Songs (the source of the lyrics i.e. what the lyrics are highlighting)
* Lyrics (a songs lyrics and translations of the lyrics)
* Artists (the creator of the songs)
* Album (a collection of songs)