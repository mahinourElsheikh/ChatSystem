class Message < ApplicationRecord
  belongs_to :chat
  validates :description, presence: true

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  document_type 'message'

  settings index: { number_of_shards: 1 } do
    mapping do
      indexes :description, type: 'string'
    end
  end

  def self.search(str)
    __elasticsearch__.search(
      {
        query: {
         match: {
            description: str
          }
        }
      }
    )
  end
end
