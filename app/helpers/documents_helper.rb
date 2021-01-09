# frozen_string_literal: true

module DocumentsHelper
  DOCUMENT_NUMBER_PATTERN = /(\d{2}-\d{4})/

  def link_documents(content, district)
    numbers = content.scan(DOCUMENT_NUMBER_PATTERN).flatten
    documents = district.documents.where(number: numbers).index_by(&:number)

    content.gsub DOCUMENT_NUMBER_PATTERN do |number|
      document = documents[number]
      if document
        link_to number, document_path(document)
      else
        number
      end
    end
  end

  def document_format(document, attribute)
    content = document.send(attribute.to_sym)
    content = link_documents(content, document.district)

    Rinku.auto_link(content, :all, 'target="_blank"')
  end
end