# frozen_string_literal: false

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require_relative '../lib/musixmatch_api'

TRACK_NAME = 'Little Monkey Rides on the Little Donkey'.freeze
MUSIXMATCH_TOKEN = YAML.safe_load(File.read(__dir__+'/../config/secrets.yml'))['ACCESS_TOKEN']
CORRECT = YAML.safe_load(File.read(__dir__+'/../spec/fixtures/musixmatch_results.yml'))

describe 'Tests Musixmatch API library' do
  before do
    @musixmatch_api = Musixmatch::MusixmatchApi.new(MUSIXMATCH_TOKEN)
  end

  it 'HAPPY: should identify track_name' do
    _(@musixmatch_api.song_track(TRACK_NAME).track_name).must_equal CORRECT['track_name']
  end

  it 'HAPPY: should identify artist_name' do
    _(@musixmatch_api.song_track(TRACK_NAME).artist_name).must_equal CORRECT['artist_name']
  end

  it 'HAPPY: should identify album_name' do
    _(@musixmatch_api.song_track(TRACK_NAME).album_name).must_equal CORRECT['album_name']
  end

  it 'HAPPY: should identify lyrics_body' do
    _(@musixmatch_api.song_lyric(TRACK_NAME).lyrics_body).must_equal CORRECT['lyrics_body']
  end

  it 'SAD: should notify the user that translations are not supported' do
    _(@musixmatch_api.song_lyric_translation(TRACK_NAME, 'es')).must_equal 'translations not enabled on this plan'
  end
end
