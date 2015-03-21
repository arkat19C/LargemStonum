# Inital Route for Page

require 'bundler'
Bundler.require

Dinosaurus.configure do |config|
  config.api_key = '86087486ed2af2d9f02674bbb54ce444'
end

fillers = %w(et un an los les vo are me te nos os por on in il ur po ank)
stone1 = Dinosaurus.synonyms_of('stone')
stone2 = Dinosaurus.related_to('stone')
stone3 = Dinosaurus.similar_to('stone')
huge1 = Dinosaurus.synonyms_of('huge')
huge2 = Dinosaurus.related_to('huge')
huge3 = Dinosaurus.similar_to('huge')
stone = stone1.concat(stone2).concat(stone3)
huge = huge1.concat(huge2).concat(huge3)
@words = huge + stone + fillers

def rand_sentence
  @op_sentence = []
  (rand(6) + 3).to_i.times do
    @op_sentence.unshift(@words.sample)
  end
  @op_sentence.join(' ').capitalize
end

def rand_paragraph(x)
  @paragraph = []
  x.times do
    @paragraph.push(rand_sentence)
  end
  @paragraph.push(' ')
  @paragraph.join('. ')
end

get '/' do
  @all_data = []
  @message = []
  @words = (stone + huge + fillers).shuffle
  erb :main
end

post '/' do
  sentences, paragraphs, pages, beginning = params[:sentences].to_i, params[:paragraphs].to_i, params[:pages].to_i , params[:beginning]
  @all_data = [sentences,paragraphs,pages,beginning]
  @words = (stone + huge + fillers).shuffle
  erb :main
end