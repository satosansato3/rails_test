module ApplicationHelper
    APP_NAME = "Study with Me".freeze

    def page_title
        base_name = APP_NAME
        return base_name if @title.blank?
        "#{base_name} | #{@title}"
    end

    def flash_message(message, klass)
        content_tag(:div, class: "alert alert-#{klass}") do
            concat content_tag(:button, "x", class: "close", data: { dismiss: "alert" })
            concat raw(message)
        end
    end
end
