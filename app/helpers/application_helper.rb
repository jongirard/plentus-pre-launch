module ApplicationHelper
  def resource_name
      :user
    end

    def resource
      @resource ||= User.new
    end

    def devise_mapping
      @devise_mapping ||= Devise.mappings[:user]
    end
    
    def cp(path)
      "active" if request.url.include?(path)
    end
end
