class Ujs::RunController < ApplicationController
  def start
    match = Match.find(params[:id])
    match.update(status: :processing)

    MergePdfJob.perform_later match

    respond_to do |format|
      format.js { render 'ujs/show/show', locals: {match: match} }
    end
  end
end
