module Mailvin
  module Web

    class Schedule
      include DataMapper::Resource
      storage_names[:default] = 'schedules'

      belongs_to :project
      has n, :templates

      property :id, Serial
      property :name, String
      property :identifier, String
      property :description, Text

      def generate properties, time = Time.now
        Sequence.new emails: \
          templates.map { |t| t.generate properties, time }
      end
    end
  end
end
