module Mailvin
  module Web

    class Project
      include DataMapper::Resource
      storage_names[:default] = 'projects'

      belongs_to :user
      has n, :sequences
      has n, :schedules

      property :id, Serial
      property :name, String

      def emails
        self.sequences.emails
      end
    end
  end
end
