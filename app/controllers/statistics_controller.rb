class StatisticsController < ApplicationController

  PARTIES = {
    'CDU' => '#222',
    'SPD' => '#dc3545',
    'Grüne' => '#28a745',
    'FDP' =>'#ffc107', 
    'Linke' => '#c535dc',
    'AfD' =>'#17a2b8', 
  }

  def show
    @proposals = make_chart_data('Anträge') do |party|
      @district.documents.proposals(party).count
    end

    @small_inquiries = make_chart_data('Anfragen') do |party|
      @district.documents.small_inquiries(party).count
    end

    @large_inquiries = make_chart_data('Anfragen') do |party|
      @district.documents.large_inquiries(party).count
    end

    @state_inquiries = make_chart_data('Anfragen') do |party|
      @district.documents.state_inquiries(party).count
    end
  end

  def make_chart_data(caption, &block)
    PARTIES.map do |party, color|
      {
        name: party,
        color: color,
        data: {
          caption => block.call(party),
        }
      }
    end
  end
end
