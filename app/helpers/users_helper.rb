module UsersHelper
  
  def users_sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def users_sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end

  def users_sort_order(column, title)
    direction = (column == users_sort_column && users_sort_direction == 'asc') ? 'desc' : 'asc'
    link_to title, { sort: column, direction: direction, search_code: params[:search_code],
    search_name: params[:search_name],search_name_kana: params[:search_name_kana],
    search_email: params[:search_email],start_date: params[:start_date],
    end_date: params[:end_date],
    search_introduction: params[:search_introduction]}, class: "fas fa-sort text-dark"
  end
end
