class Word < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
	validates :description, presence: true
    has_many :keywords, dependent: :destroy
    def key_word_strings
        self.keywords.map(&:string) #array of keywords
    end
    after_save do |word|
        common_words = ["to", "a", "is" ,"an", "you","our" "there", "their", "how", "why", "where", "what" ,"as", "it", "and", "but", "we", "i", "are", "was"]
        kws = word.description.split(/\W+/).uniq
        kws.map{|x| x.downcase}
        kws.delete_if{|x| common_words.include?(x.downcase)}
        kws.each do |kw|
            word.keywords.create(string: kw).save
        end
    end 
end
