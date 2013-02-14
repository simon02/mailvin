module Mailvin
  module Web

    class Sequence
      include DataMapper::Resource
      storage_names[:default] = 'sequences'

      belongs_to :schedule
      has_many :emails

      property :id, Serial
    end
  end
end
