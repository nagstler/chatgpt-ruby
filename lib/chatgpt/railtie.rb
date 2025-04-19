# lib/chatgpt/railtie.rb
module ChatGPT
    class Railtie < Rails::Railtie
      initializer "chatgpt.configure_rails_initialization" do
        # Register inflection for Rails apps
        ActiveSupport::Inflector.inflections(:en) do |inflect|
          inflect.acronym 'GPT'
        end
      end
    end
end