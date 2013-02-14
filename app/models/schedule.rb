module Mailvin
  module Web

    class Schedule
      include DataMapper::Resource
      storage_names[:default] = 'schedules'

      belongs_to :account
      has_many :templates
      has_many :emails

      property :name, String

      def generate properties, time = Time.now
        Sequence.new emails: \
          templates.map { |t| t.generate properties, time }
      end
    end
  end
end
