module User::Equipment::ChangeLogsHelper
  
  def change_logs_sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
  
  def change_logs_sort_column
    ChangeLog.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end

  def change_logs_sort_order(column, title)

    direction = (column == change_logs_sort_column && change_logs_sort_direction == 'asc') ? 'desc' : 'asc'
    link_to title, { sort: column, direction: direction, search_name: params[:search_name], 
    search_reference_number: params[:search_reference_number],search_model: params[:search_model],
    search_location: params[:search_location],search_date: params[:search_date],
    search_introduction: params[:search_introduction],search_notes: params[:search_notes],
    search_user: params[:search_user],start_date: params[:start_date],end_date: params[:end_date]},
    class: "fas fa-sort text-dark"
  end
end
