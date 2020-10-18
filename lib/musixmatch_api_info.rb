# frozen_string_literal: false

require 'http'
require 'yaml'
require 'fileutils'

####################################
## API
####################################
def call_musixmatch(path, params = {})
  response = JSON.parse(
    HTTP
    .headers("Content-Type": 'application/json')
    .get(
      "https://api.musixmatch.com/ws/1.1/#{path}",
      params: params.merge({ "apikey": MUSIXMATCH_TOKEN, format: 'json' })
    ).body
  )

  response['message']
end

####################################
## Configuration
####################################
TRACK_NAME = 'Little Monkey Rides on the Little Donkey'.freeze
MUSIXMATCH_TOKEN = YAML.safe_load(File.read(__dir__+'/../config/secrets.yml'))['ACCESS_TOKEN']
api_results = {}

####################################
## HAPPY project request
####################################
puts 'Start HTTP requests...'
puts

search = call_musixmatch(
  'track.search',
  { q_track: TRACK_NAME }
)

# By default, find the 1st search result
track = search['body']['track_list'][0]['track']

api_results['track_name'] = track['track_name'] # WAP (feat. Megan Thee Stallion)
api_results['artist_name'] = track['artist_name'] # Cardi B feat. Megan Thee Stallion
api_results['album_name'] = track['album_name'] # WAP (feat. Megan Thee Stallion)

puts 'track_name:'
puts api_results['track_name']
puts

puts 'artist_name:'
puts api_results['artist_name']
puts

puts 'album_name:'
puts api_results['album_name']
puts

lyrics_get = call_musixmatch(
  'track.lyrics.get',
  { track_id: track['track_id'] }
)

api_results['lyrics_body'] = lyrics_get['body']['lyrics']['lyrics_body'] # Whores in this house

puts 'lyrics_body:'
puts api_results['lyrics_body']
puts

####################################
## BAD project request
####################################
# This calls the translation API but a 403 is returned since we don't have access to this part of the API.
translation = call_musixmatch(
  'track.lyrics.translation.get',
  { selected_language: 'es', track_id: track['track_id'] }
)

api_results['translation'] = translation['header']['hint'] # translations not enabled on this plan

puts 'translation:'
puts api_results['translation']
puts

####################################
## Write Testing File
####################################
FileUtils.mkdir_p(__dir__+"/../spec/fixtures")
File.write(__dir__+'/../spec/fixtures/musixmatch_results.yml', api_results.to_yaml)
