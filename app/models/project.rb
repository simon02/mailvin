module Mailvin
  module Web

    class Project
      include DataMapper::Resource
      storage_names[:default] = 'projects'

      belongs_to :user
      has n, :mailboxes
      has n, :schedules

      property :id, Serial
      property :name, String

      def emails
        begin
          self.mailboxes.sequences.emails
        rescue
          []
        end
      end
    end
  end
end
