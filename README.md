# MusixMatch API Client

Project to gather useful information from MusixMatch API V 1.1. The base URL is `https://api.musixmatch.com/ws/1.1/`

## Resources

* Songs
* Artists
* Albums
* Lyrics

## Elements

* Songs
  - song_id
  - name
  - year
  - artist_id
  - lyrics_id

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

* Lyrics
  - lyric_id
  - song_id
  - text
  - whether its a translation translation
  - language

## Entities

* Songs (the source of the lyrics i.e. what the lyrics are highlighting)
* Artists (the creator of the songs)
* Albums (a collection of songs)
* Lyrics (a songs lyrics and translations of the lyrics)



## Get Started

* Installation
  * `rbenv local 2.7.1`
  * `bundle install`
* Authentication
  * Put your ACCESS_TOKEN into config/secrets.yml
* Generate testfile (spec/fixtures/musixmatch_results.yml)
  * `$ bundle exec ruby lib/musixmatch_api_info.rb`
* Test the APIs
  * `$ bundle exec ruby spec/musixmatch_api_spec.rb`

