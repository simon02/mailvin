module Mailvin
  module Web

    class Template
      include DataMapper::Resource
      storage_names[:default] = 'templates'

      belongs_to :schedule

      property :delay_type, Enum(:precise, :scheduled)
      property :precise_delay, Integer
      property :scheduled_delay
      property :text, Text

      def generate properties, time = Time.now
        Email.new(properties.merge scheduled_at:
          calculate_scheduled_at(time))
      end

      private

      def calculate_scheduled_at from
      end
    end
  end
end
