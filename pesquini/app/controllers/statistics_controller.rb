class StatisticsController < ApplicationController

  def  index
#    @enterprises = Enterprise.featured
  end

  def most_sanctioned_ranking
    @enterprises = Enterprise.featured
  end

  def sanction_by_state_graph
    gon.states = @@states_list
    gon.dados = total_by_state
    @titulo = "Gráfico de Sanções por Estado"
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
    f.title(:text => "Gráficos de Sanções por Estado")
    f.xAxis(:categories => @@states_list)
    f.series(:name => "Numero de Sanções", :yAxis => 0, :data => total_by_state)
    f.yAxis [
    {:title => {:text => "Sanções", :margin => 70} },
    {:title => {:text => "Sanções"}, :opposite => true},
    ]

    f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
    f.chart({:defaultSeriesType=>"column"})
end

  end

  def total_by_state
    @results = []
    @@states_list.each do |s|
      state = State.find_by_abbreviation("#{s}")
      sanctions_by_state = Sanction.where(state_id: state[:id])
    @results << (sanctions_by_state.count)
    end
    @results
  end

end