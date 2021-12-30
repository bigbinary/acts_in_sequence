# frozen_string_literal: true

require "acts_in_sequence/version"

require "active_record"
require "acts_in_sequence/core"

module ActsInSequence
  class Error < StandardError; end

  def acts_in_sequence?
    included_modules.include?(ActsInSequence::Core)
  end

  def acts_in_sequence(options = {})
    raise ArgumentError, "acts_in_sequence => Hash expected, got #{options.class.name}" if !options.is_a?(Hash)

    class_attribute :sequencing_configuration

    self.sequencing_configuration = {
      scope: options[:scope],
      column_name: "sequence",
      default_order: "ASC"
    }

    if options[:column_name].present?
      sequencing_configuration[:column_name] = options[:column_name]
    end

    if options[:default_order].present?
      sequencing_configuration[:default_order] = options[:default_order].to_s.downcase == "desc" ? "DESC" : "ASC"
    end

    return if acts_in_sequence?

    include ActsInSequence::Core

    # Scopes
    default_scope { order(sequencing_configuration[:column_name] => sequencing_configuration[:default_order]) }
    scope :without_sequence_order, -> { reorder("") }

    # Assign sequence before create
    before_create :assign_sequence_before_create, if: :sequence_is_not_set?
  end
end

# Extend ActiveRecord's functionality
ActiveRecord::Base.extend ActsInSequence
