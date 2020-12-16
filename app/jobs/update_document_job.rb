# frozen_string_literal: true

class UpdateDocumentJob < ApplicationJob
  def perform(document)
    document.retrieve_from_allris
    document.save!
  end
end
