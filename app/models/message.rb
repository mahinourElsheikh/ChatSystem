class Message < ApplicationRecord
  belongs_to :chat
  validates :description, presence: true
  validates :seq_num, uniqueness: { scope: :chat }

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  document_type 'message'

  settings index: { number_of_shards: 1 } do
    mapping do
      indexes :description, type: 'string'
    end
  end

  def self.search(str, ch_id)
    __elasticsearch__.search(
      {
        query: {
          bool: {
            must: [
              {
                match: {
                  description: {
                    query: str,
                    operator: 'and'
                  }
                }
              },
              match: {
                chat_id: {
                  query: ch_id,
                  operator: 'and'
                  }
              }
            ]
          }
        }
      }
    )
  end
end
