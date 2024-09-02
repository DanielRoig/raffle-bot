module Button
    class Button
        def initialize(text, callback_data)
            @text = text
            @callback_data = callback_data
        end

        def self.generate(text, callback)
            new(text, callback).result
        end
        
        def result
            { text: , callback_data: }
        end

        attr_reader :text, :callback_data
    end
end