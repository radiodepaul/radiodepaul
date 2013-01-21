module JSONTools
  class ModelCacheKey
    attr_reader :model, :scope

    def initialize(model, scope)
      @model = model
      @scope = scope
    end

    def key
      @key ||= [
        model.class.name,
        model.id,
        model.updated_at.to_i,
        scope.role
      ].join('-')
    end
  end
end
