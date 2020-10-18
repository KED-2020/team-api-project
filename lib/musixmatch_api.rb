# frozen_string_literal: false

require 'http'
require_relative 'song_track'
require_relative 'song_lyric'

module Musixmatch
  # Library for Musixmatch Web API
  class MusixmatchApi
    def initialize(token)
      @access_token = token
    end

    def song_track(track_name)
      search = call_musixmatch('track.search', { q_track: track_name })

      SongTrack.new(search['body']['track_list'][0]['track'])
    end

    def song_lyric(track_name)
      search = call_musixmatch('track.search', { q_track: track_name })
      track = search['body']['track_list'][0]['track']

      lyrics_get = call_musixmatch('track.lyrics.get', { track_id: track['track_id'] })

      SongLyric.new(lyrics_get['body']['lyrics'])
    end

    private

    def call_musixmatch(path, params = {})
      response = JSON.parse(
        HTTP
        .headers("Content-Type": 'application/json')
        .get(
          "https://api.musixmatch.com/ws/1.1/#{path}",
          params: params.merge({ "apikey": @access_token, format: 'json' })
        )
        .body
      )

      response['message']
    end
  end
end
