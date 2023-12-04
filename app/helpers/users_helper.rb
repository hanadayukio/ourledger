module UsersHelper
  # 'asc''desc'を含んでいるか確認
  def users_sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
  # params[sort]がUserモデルのカラム名に含まれているか確認
  def users_sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end
  # columとtitleの2つの引数を取得
  def users_sort_order(column, title)
    # 現在のソートの方向を決定する昇順か降順にするか
    direction = (column == users_sort_column && users_sort_direction == 'asc') ? 'desc' : 'asc'
    link_to title, { sort: column, direction: direction, search_code: params[:search_code],
    search_name: params[:search_name],search_name_kana: params[:search_name_kana],
    search_email: params[:search_email],start_date: params[:start_date],
    end_date: params[:end_date],
    search_introduction: params[:search_introduction]}, class: "fas fa-sort text-dark"
  end
end
