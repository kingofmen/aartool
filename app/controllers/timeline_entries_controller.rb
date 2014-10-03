class TimelineEntriesController < ApplicationController
  def create
    @timeline = Timeline.find(params[:timeline_id])
    @entry = @timeline.timeline_entries.create(process_params)
    @entry.save
    redirect_to timeline_path(@timeline)
  end

  def destroy
    @timeline = Timeline.find(params[:timeline_id])
    @entry = @timeline.timeline_entries.find(params[:id])
    @entry.destroy
    redirect_to timeline_path(@timeline)
  end

  def edit
    @timeline = Timeline.find(params[:timeline_id])
    @entry = @timeline.timeline_entries.find(params[:id])
  end

  def update
    @timeline = Timeline.find(params[:timeline_id])
    @entry = @timeline.timeline_entries.find(params[:id])
    @entry.update(process_params)
    redirect_to timeline_path(@timeline)
  end

private
  def process_params
    ret = {}
    entry = params.require(:timeline_entry).permit(:short_title, :long_description)
    ret[:short_title] = entry[:short_title]
    ret[:long_description] = entry[:long_description]
    date = params.require(:time).permit(:year, :month, :day)
    ret[:time] = Date.new(date[:year].to_i, date[:month].to_i, date[:day].to_i)
    return ret
  end
end
