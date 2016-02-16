class HomeController < ApplicationController
  def index
  	if Admin.all.count==0
  		redirect_to "/admins/sign_up"
  	end
    @words = Word.order('lower(name) ASC').all
    @related_word = []
    @csv = []
    Word.all.each do |word|
        @related_word = @related_word.append({name: word.name, size: 1, url: word_path(word), desc: word.description})
        @csv = @csv.append({name: word.name, count: 1, url: word_path( word, :format => :json ), desc: word.description})
    end
    @related_word = @related_word.sort_by{ |a| a[:index] }.reverse
    @related_word_json = {name: "flare", children: @related_word}
    respond_to do |format|
        format.html #index.html.erb
        format.json { render json: @csv }
    end

  end
end
