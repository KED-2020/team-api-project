# frozen_string_literal: true

require 'http'
require 'yaml'

ACCESS_TOKEN = YAML.safe_load(File.read('config/secrets.yml'))['ACCESS_TOKEN']

def call_musixmatch(path, params = {})
  response = JSON.parse(
    HTTP
    .headers("Content-Type": 'application/json')
    .get(
      "https://api.musixmatch.com/ws/1.1/#{path}",
      params: params.merge({ "apikey": ACCESS_TOKEN, format: 'json' })
    ).body
  )

  response['message']
end

api_response = {}

api_response['search'] = call_musixmatch('track.search', { q_track: 'WAP (feat. Megan Thee Stallion)' })
track = api_response['search']['body']['track_list'][0]['track']

api_response['artist'] = call_musixmatch('artist.get', { artist_id: track['artist_id'] })
artist = api_response['artist']['body']['artist']

api_response['lyrics'] = call_musixmatch('track.lyrics.get', { track_id: track['track_id'] })
lyrics = api_response['lyrics']['body']['lyrics']

# This calls the translation API but a 403 is returned since we don't have access to this part of the API.
api_response['translation'] = call_musixmatch(
  'track.lyrics.translation.get',
  { selected_language: 'es', track_id: track['track_id'] }
)
translation = api_response['translation']['header']['hint']

api_response['album'] = call_musixmatch('album.get', { album_id: track['album_id'] })
album = api_response['album']['body']['album']

api_results = {
  track: track,
  artist: artist,
  lyrics: lyrics,
  album: album,
  translation: translation
}

File.write('spec/fixtures/results.yml', api_results.to_yaml)
