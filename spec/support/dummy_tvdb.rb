module DummyTVDB
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
    [_archer_base, _other_archer_one, _other_archer_two]
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
