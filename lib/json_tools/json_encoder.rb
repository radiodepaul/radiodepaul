module JSONTools
  class JSONEncoder
    def load(value)
      JSON.load(value) if value
    end

    def dump(value)
      JSON.dump(value)
    end
  end
end
