# frozen_string_literal: true

require 'http'
require 'yaml'

class MusixmatchMix

  def initialize(token, track_name)
    @access_token = token
    init_track(track_name)
  end

  def init_track(track_name)

    search = call_musixmatch('track.search', { q_track: track_name})
    @track = search['body']['track_list'][0]['track']

  end

  def track_name()

    @track['track_name'] # WAP (feat. Megan Thee Stallion)

  end

  def artist_name()

    @track['artist_name'] # Cardi B feat. Megan Thee Stallion

  end

  def album_name()

    @track['album_name'] # WAP (feat. Megan Thee Stallion)

  end

  def lyrics_body()

    lyric = call_musixmatch('track.lyrics.get', { track_id: @track['track_id'] })
    lyric['body']['lyrics']['lyrics_body']

  end



  private

  def call_musixmatch(path, params = {})
    response = JSON.parse(
      HTTP
      .headers("Content-Type": 'application/json')
      .get(
        "https://api.musixmatch.com/ws/1.1/#{path}",
        params: params.merge({ "apikey": @access_token, format: 'json' }))
      .body
    )

    response['message']
  end

end

# TRACK_NAME = 'WAP (feat. Megan Thee Stallion)'
# MUSIXMATCH_TOKEN = YAML.safe_load(File.read('config/secrets.yml'))['ACCESS_TOKEN']
# CORRECT = YAML.safe_load(File.read('spec/fixtures/musixmatch_results.yml'))
# musixmatch_api = MusixmatchMix.new(MUSIXMATCH_TOKEN,TRACK_NAME)

# puts musixmatch_api.track_name()
# puts CORRECT['track_name']
# puts

# puts musixmatch_api.artist_name()
# puts CORRECT['artist_name']
# puts

# puts musixmatch_api.album_name()
# puts CORRECT['album_name']
# puts

# puts musixmatch_api.lyrics_body()
# puts CORRECT['lyrics_body']
# puts




