module RegistersHelper
  
# userソート用
  def user_registers_sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
  
  def user_registers_sort_column
    Register.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end

  def user_registers_sort_order(column, title)

    direction = (column == user_registers_sort_column && user_registers_sort_direction == 'asc') ? 'desc' : 'asc'
    link_to title, { sort: column, direction: direction, search_name: params[:search_name], 
    search_reference_number: params[:search_reference_number],search_detail: params[:search_detail]},
    class: "fas fa-sort text-dark"
  end

# adminソート用
  def admin_registers_sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
  
  def admin_registers_sort_column
    Register.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end

  def admin_registers_sort_order(column, title)

    direction = (column == admin_registers_sort_column && admin_registers_sort_direction == 'asc') ? 'desc' : 'asc'
    link_to title, { sort: column, direction: direction, search_name: params[:search_name], 
    search_reference_number: params[:search_reference_number],search_detail: params[:search_detail]},
    class: "fas fa-sort text-dark"
  end
end
