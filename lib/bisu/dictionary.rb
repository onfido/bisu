module Bisu
  class Dictionary
    def initialize(keys)
      unless keys.is_a?(Hash)
        raise ArgumentError.new("keys: expected Hash, got #{keys.class}")
      end

      keys.each do |lang,v|
        unless v.is_a?(Hash)
          raise ArgumentError.new("keys['#{lang}']: expected Hash, got #{v.class}")
        end

        v.each do |key,v|
          unless v.is_a?(String) || v.nil?
            raise ArgumentError.new("keys['#{lang}']['#{key}']: expected String, got #{v.class}")
          end
        end
      end

      @keys = Hash[keys.map { |k,v| [k.downcase, v] }]
    end

    def has_language?(language)
      @keys.include?(language&.downcase)
    end

    def localize(language, key)
      if has_language?(language)
        @keys[language&.downcase][key]
      else
        nil
      end
    end
  end
end
