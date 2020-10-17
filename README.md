# MusixMatch API Client

Project to gather useful information from MusixMatch API V 1.1. The base URL is `https://api.musixmatch.com/ws/1.1/`


## Resources

* Songs
* Artists
* Albums
* Lyrics


## Elements

* Songs
  - track name
  - artist name
  - album name
  - lyric body


## Entities

* SongTrack 
* SongLyric 


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

