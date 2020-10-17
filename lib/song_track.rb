# frozen_string_literal: false

module Musixmatch
  # Model for SongTrack
  class SongTrack
    def initialize(track_data)
      @track = track_data
    end

    def track_name
      @track['track_name']
    end

    def artist_name
      @track['artist_name']
    end

    def album_name
      @track['album_name']
    end
  end
end