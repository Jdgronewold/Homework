module Toyable
  extend ActiveSupport::Concern

  included do
    has_many :toys, as: :toyable
  end

  def receive_toy(name)
    Toy.find_or_create(name: name, toyable_id: self.id)
  end
end
