class TimelinesController < ApplicationController
  def index
  end

  def new
  end

  def create
    @timeline = Timeline.new(process_params)
    @timeline.save
    redirect_to @timeline
  end

  def show
    @timeline = Timeline.find(params[:id])
  end

  private
  def process_params
    # We want a map from the members of Timeline to the submitted
    # values. The submitted values are ActionController::Parameter 
    # objects, mapped in 'params'. We will require objects to exist,
    # and permit (would prefer to require) them to have certain fields.
    # Then we'll look up the fields and put them into our return map. 
    # There is probably a better way to do this. 
    ret = {}
    ret[:short_title] = params.require(:timeline).permit(:short_title)[:short_title]
    start_date = params.require(:start_date).permit(:year, :month, :day)
    ret[:start_date] = Date.new(start_date[:year].to_i, start_date[:month].to_i, start_date[:day].to_i)
    end_date = params.require(:end_date).permit(:year, :month, :day)
    ret[:end_date] = Date.new(end_date[:year].to_i, end_date[:month].to_i, end_date[:day].to_i)
    return ret
  end
end
