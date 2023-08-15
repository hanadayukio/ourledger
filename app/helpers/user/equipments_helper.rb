module User::EquipmentsHelper
  
  def equipments_sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def equipments_sort_column
    Equipment.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end

  def equipments_sort_order(column, title)
    direction = (column == equipments_sort_column && equipments_sort_direction == 'asc') ? 'desc' : 'asc'
    link_to title, { sort: column, direction: direction, search_name: params[:search_name],
    search_reference_number: params[:search_reference_number],search_model: params[:search_model],
    search_location: params[:search_location],search_date: params[:search_date],
    search_introduction: params[:search_introduction]}, class: "fas fa-sort text-dark"
  end
end