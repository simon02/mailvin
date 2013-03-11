module Mailvin
  module Web

    class Sequence
      include DataMapper::Resource
      storage_names[:default] = 'sequences'

      belongs_to :project
      belongs_to :schedule, required: false
      has n, :emails

      property :id, Serial
    end
  end
end
