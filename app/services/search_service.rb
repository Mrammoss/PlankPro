class SearchService

  def initialize(user, resource_class, query = nil, order_column = :name)
    @user = user 
    @resource_class = resource_class
    @query = query
    @order_column = order_column
  end

  def call 
    resources = @user.public_send(resource_class_name.underscore.pluralize).order(@order_column)
    resources = resources.where("name ILIKE ?", "%#{@query}%") if @query.present?
    resources
  end

  private

  def resource_class_name
    @resource_class.name
  end 
end
