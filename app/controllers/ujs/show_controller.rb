class Ujs::ShowController < ApplicationController
  include ActionController::Live

  def show
    job = Job.find(params[:id])

    response.headers['Content-Type'] = 'text/event-stream'
    sse = SSE.new(response.stream, event: :change)
    begin
      loop do
        sleep 5
        job.matches.where(updated_at: (Time.now - 5.seconds)..Time.now).find_each do |match|
          sse.write(render_to_string 'ujs/show/show', locals: {match: match})
        end
        sse.write '' # Bug, needs to have something written, or else never closes
      end
    rescue ClientDisconnected
    ensure
      sse.close
    end
  end
end
