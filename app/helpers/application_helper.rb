module ApplicationHelper
    APP_NAME = "Study with Me".freeze

    def page_title
        base_name = APP_NAME
        return base_name if @title.blank?
        "#{base_name} | #{@title}"
    end
end
