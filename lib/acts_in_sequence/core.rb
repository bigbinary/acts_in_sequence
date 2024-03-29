# frozen_string_literal: true

module ActsInSequence
  module Core
    protected
      def sequence_is_not_set?
        _val = self[sequencing_configuration[:column_name]]
        _val.nil? || _val.zero?
      end

      def assign_sequence_before_create
        self[sequencing_configuration[:column_name]] = deduce_last_sequence + 1
      end

      def deduce_last_sequence
        build_sequencing_query.maximum(sequencing_configuration[:column_name]).to_i
      end

      def build_sequencing_query
        for_name = sequencing_configuration[:scope]
        return self.class if for_name.blank?

        self.class.default_scoped.where(for_name => self.send(for_name))
      end
  end
end
