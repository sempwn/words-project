class WordsController < ApplicationController
	before_action :authenticate_admin!
	skip_before_action :authenticate_admin!, only: [:index, :show]
	def index
		@words = Word.order('lower(name) ASC').all

		
	end
	def new
		@word = Word.new

	end
	def create
  		@word = Word.new(word_params)

  		if @word.save
  			redirect_to word_path(@word)
  		else
  			render 'new'
  		end
	end
	def show
		@word = Word.find(params[:id])
		keywords = @word.key_word_strings
		
		@related_word = []
		@csv = []
		Word.all.each do |word|
			if not word.name == @word.name
				index = (keywords & word.key_word_strings).count
				@related_word = @related_word.append({name: word.name, size: index, url: word_path(word)})
				@csv = @csv.append({name: word.name, count: index, url: word_path( word, :format => :json ), desc: word.description})
			end

		end
		@related_word = @related_word.sort_by{ |a| a[:index] }.reverse.first(10)
		@related_word_json = {name: "flare", children: @related_word}
		respond_to do |format|
  			format.html #show.html
  			format.json { render json: @csv }
		end
		

	end

	def edit
		@word = Word.find(params[:id])
	end

	def update
		@word = Word.find(params[:id])
		if @word.update(word_params)
			redirect_to word_path(@word)
		else
			render 'edit'
		end
	end

	def destroy
		@word = Word.find(params[:id])
		@word.destroy

		redirect_to words_path
	end

	private
		def word_params
			params.require(:word).permit(:name, :description)
		end
end
