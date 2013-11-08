module IMS::CC
  class Metadata
    include HappyMapper

    tag 'metadata'
    element :schema, String
    element :schemaversion, String
    has_one :lom, IMS::CC::Lom::Lom
  end
end
