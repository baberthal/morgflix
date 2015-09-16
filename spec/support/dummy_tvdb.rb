module DummyTVDB
  def self.included(base)
    base.extend GroupMethods
  end

  def read_xml(file)
    MultiXml.parse(File.read(Rails.root.join("spec/support/tvdb/#{file}.xml")))
  end

  def dummy_raw_actors
    read_xml('actors')
  end

  def dummy_raw_full_series
    read_xml('en')
  end

  def dummy_raw_banners
    read_xml('banners')
  end

  def dummy_raw_search
    read_xml('search_results')
  end

  def bad_search_response
    read_xml('bad_results')
  end

  module GroupMethods
    def stub_tvdb
      before do
        allow(TVDB::SeriesSearch).to receive(:response)
          .and_return dummy_raw_full
        allow(TVDB::BasicSearch).to receive(:response)
          .and_return dummy_search_response
        allow(TVDB::Banner).to receive(:download).and_return true
      end
    end
  end

  def dummy_raw_full
    {
      'en' => dummy_raw_full_series,
      'banners' => dummy_raw_banners,
      'actors' => dummy_raw_actors
    }
  end

  # rubocop:disable Metrics/MethodLength
  def dummy_info_response
    {
      'id' => '110381',
      'SeriesName' => 'Archer (2009)',
      'Overview' => _overview,
      'FirstAired' => '2009-09-17',
      'Actors' => _actors,
      'Airs_DayOfWeek' => 'Thursday',
      'Airs_Time' => '10:00 PM',
      'ContentRating' => 'TV-MA',
      'Network' => 'FXX',
      'IMDB_ID' => 'tt1486217',
      'zap2it_id' => 'EP01216702',
      'Genre' => '|Action|Adventure|Animation|Comedy|Drama|',
      'Language' => 'en',
      'NetworkID' => nil,
      'Rating' => '9.2',
      'RatingCount' => '240',
      'Runtime' => '20',
      'SeriesID' => '77555',
      'Status' => 'Continuing',
      'added' => '2009-08-23 04:13:16',
      'addedBy' => '235',
      'banner' => 'graphical/110381-g8.jpg',
      'fanart' => 'fanart/original/110381-23.jpg',
      'lastupdated' => '1441911867',
      'poster' => 'posters/110381-9.jpg',
      'tms_wanted_old' =>  1
    }
  end
  # rubocop:enable all

  def raw_response
    {
      en: {
        'Data' => {
          'Series' => dummy_info_response
        }
      }
    }
  end

  def single_response
    {
      id: 110_381,
      name: 'Archer (2009)',
      network: 'FXX',
      language: 'en'
    }
  end

  def dummy_search_response
    dummy_raw_search['Data']['Series']
  end

  private

  def _overview
    text = <<-EOF
    At ISIS, an international spy agency, global crises are merely opportunities
for its highly trained employees to confuse, undermine, betray and royally screw
each other. At the center of it all is suave master spy Sterling Archer, whose
less-than-masculine code name is Duchess. Archer works with his domineering
mother Malory, who is also his boss.  Drama revolves around Archers
ex-girlfriend, Agent Lana Kane and her new boyfriend, ISIS comptroller Cyril
Figgis, as well as Malorys lovesick secretary, Cheryl.
    EOF
    text.squish
  end

  def _actors
    actors = <<-EOF
    |H. Jon Benjamin|Aisha Tyler|Jessica Walter|George Coe|Adam Reed|Lucky
    Yates|Amber Nash|Chris Parnell|Judy Greer|
    EOF
    actors.squish
  end

  def _archer_base
    {
      id: 110_381,
      name: 'Archer (2009)',
      network: 'FXX',
      language: 'en'
    }
  end

  def _other_archer_one
    {
      id: 73_065,
      name: 'Archer',
      network: 'NBC',
      language: 'en'
    }
  end

  def _other_archer_two
    {
      id: 248_777,
      name: 'The Green Archer',
      network: nil,
      language: 'en'
    }
  end
end
