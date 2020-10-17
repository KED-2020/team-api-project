# frozen_string_literal: false

module Musixmatch
  # Model for SongLyric
  class SongLyric
    def initialize(lyric_data)
      @lyric = lyric_data
    end

    def lyrics_body
      @lyric['lyrics_body']
    end
  end
end
